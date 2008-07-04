package MusicBrainz::Server::Controller::Artist;

use strict;
use warnings;
use parent 'Catalyst::Controller';

use Encode qw( decode );
use ModDefs;
use MusicBrainz::Server::Alias;
use MusicBrainz::Server::Artist;
use MusicBrainz::Server::Link;
use MusicBrainz::Server::Release;
use MusicBrainz::Server::Tag;
use MusicBrainz::Server::URL;
use MusicBrainz::Server::Validation;
use MusicBrainz;

=head1 NAME

MusicBrainz::Server::Controller::Artist - Catalyst Controller for working with Artist entities

=head1 DESCRIPTION

=head1 METHODS

=head2 artistLink

Create stash data to create a link to an artist, in an form that can be then displayed by
root/components/entity-link.tt

=cut

sub artistLink
{
    my $artist = @_;

    artistLinkRaw $artist->GetName, $artist->GetMBId;
}

=head2 artistLinkRaw

Create stash data to link to an artist, but given the parameters explicity (rather than requiring an
Artist object)

=cut

sub artistLinkRaw
{
    my ($name, $mbid) = @_;

    {
        name => $name,
        mbid => $mbid,
        type => 'artist'
    };
}

=head2 appearances

Display a list of releases that an artist appears on; that is - does not have the actual release
attributed to them, but somehow appear on the release via an AR.

=cut

sub appearances : Local Args(1) MyAction('ArtistPage')
{
    my ($self, $c) = @_;
    my $artist = $c->stash->{_artist};
    my $mb = $c->mb;

    my $link = new MusicBrainz::Server::Link($mb->{DBH});
    my @rawReleases = @{$link->FindLinkedAlbums("artist", $artist->GetId)};

    for my $release (@rawReleases)
    {
        $release->{_name_sort_} = lc decode "utf-8", $release->{name};
        $release->{_disc_no_} = 0;

        # Attempt to sort "disc x" correctly
        if ($release->{_name_sort_} =~
            /^(.*)                              # $1 <main title>
                (?:[(]disc\ (\d+)               # $2 (disc x
                    (?::[^()]*                  #    [: <disc title>
                        (?:[(][^()]*[)][^()]*)* #     [<1 level of nested par.>]
                    )?                          #    ]
                    [)]                         #    )
                )
                (.*)$                           # $4 [<rest of main title>]
            /xi)
        {
            $release->{_name_sort_} = "$1 $3";
            $release->{_disc_no_} = $2;
        }

        $release->{date} = $release->{begindate};
        $release->{date} =~ s/\s+//;
        $release->{date} = $release->{firstreleasedate} if !$release->{date};
        $release->{_sort_date_} = ($release->{date} || "9999-99-99");
    }
    
    @rawReleases = sort {
        ($a->{linkphrase} cmp $b->{linkphrase}) or
        ($a->{_sort_date_} cmp $b->{_sort_date_}) or
        ($a->{_name_sort_} cmp $b->{_name_sort_}) or
        ($a->{_disc_no_} <=> $b->{_disc_no_})
    } @rawReleases;
   
    my @releaseGroups;
    my $group;
    for my $release (@rawReleases)
    {
        die "No release" unless defined $release;

        if(not defined $group or $release->{linkphrase} ne $group->{phrase})
        {
            $group = {
                phrase => $release->{linkphrase},
                releases => []
            };

            push @releaseGroups, $group;
        }

        my $stashRelease = MusicBrainz::Server::Controller::Release::releaseLinkRaw($release->{name}, "???");
        $stashRelease->{artist} = MusicBrainz::Server::Controller::Artist::artistLinkRaw($release->{artist_name}, "???");
        $stashRelease->{year} = substr($release->{date}, 0, 4) || '?';

        push @{$group->{releases}}, $stashRelease;
    }

    $c->stash->{release_groups} = \@releaseGroups;
    $c->stash->{template} = 'artist/appearances.tt';
}

=head2 perma

Display the perma-link for a given artist

=cut

sub perma : Local Args(1) MyAction('ArtistPage')
{
    my ($self, $c) = @_;
    my $artist = $c->stash->{_artist};
    $c->stash->{template} = 'artist/perma.tt';
}

=head2 details

Display detailed information about a specific artist

=cut

sub details : Local Args(1) MyAction('ArtistPage')
{
    my ($self, $c, $mbid) = @_;

    my $mb = new MusicBrainz;
    $mb->Login();

    my $artist = $c->stash->{_artist};
    $artist->{DBH} = $mb->{DBH};

    $c->stash->{details} = {
        subscriber_count => scalar $artist->GetSubscribers
    };

    $c->stash->{template} = 'artist/details.tt';
}

=head2 aliases

Display all aliases of an artist, along with usage information

=cut

sub aliases : Local Args(1) MyAction('ArtistPage')
{
    my ($self, $c, $mbid) = @_;

    my $artist = $c->stash->{_artist};

    my $alias = MusicBrainz::Server::Alias->new($c->mb->{DBH}, "ArtistAlias");
    my @aliases = $alias->GetList($artist->GetId);

    my @prettyAliases = ();
    for my $alias (@aliases)
    {
        push @prettyAliases, {
            name => $alias->[1],
            useCount => $alias->[2],
            used => !($alias->[3] =~ /^1970-01-01/)
        }
    }

    $c->stash->{aliases} = \@prettyAliases;
    $c->stash->{template} = 'artist/aliases.tt';
}

=head2 show

Shows an artist's main landing page, showing all of the releases that are attributed to them

=cut

sub show : Path Args(1) MyAction('ArtistPage')
{
    my ($self, $c, $mbid) = @_;

    # Load the artist
    my $mb = $c->mb;
    my $artist = $c->stash->{_artist};

    # Load data for the landing page
    my @tags = LoadArtistTags ($mb->{DBH}, 5, $artist);
    my @arLinks = LoadArtistARLinks ($mb->{DBH}, $artist); 
    my @releases = LoadArtistReleases ($artist);

    # Create data structures for the template
    #

    # ARs:
    my @prettyArs;
    my $currentArGroup = undef;
    for my $ar (@arLinks)
    {
        if(not defined $currentArGroup or $currentArGroup->{connector} ne $ar->{link_phrase})
        {
            $currentArGroup = {
                connector => $ar->{link_phrase},
                type => $ar->{link_type},
                entities => []
            };
            push @prettyArs, $currentArGroup;
        }

        my $entity;

        if ($ar->{link1_type} eq 'artist')
        {
            $entity = artistLinkRaw($ar->{link1_name}, $ar->{link1_mbid});
        }
        elsif ($ar->{link1_type} eq 'album')
        {
            $entity = MusicBrainz::Server::Controller::Release::releaseLinkRaw($ar->{link1_name},
                $ar->{link1_mbid});
        }
        elsif ($ar->{link1_type} eq 'url')
        {
            $entity = MusicBrainz::Server::Controller::Url::urlLinkRaw($ar->{link1_name},
                $ar->{link1_mbid});
        }

        push @{$currentArGroup->{entities}}, $entity;
    }

    # Artist:
    $c->stash->{_artist} = $artist;
    $c->stash->{artist_tags} = \@tags;
    $c->stash->{artist_relations} = \@prettyArs;

    # Releases, sorted into "release groups":
    $c->stash->{groups} = [];

    my $currentGroup;
    for my $release (@releases)
    {
        my ($type, $status) = $release->GetReleaseTypeAndStatus;

        # Releases should have sorted into groups, so if $type has changed, we need to create
        # a new "release group"
        if(not defined $currentGroup or $currentGroup->{type} != $type)
        {
            $currentGroup = {
                name => $release->GetAttributeNamePlural($type),
                releases => [],
                type => $type
            };

            push @{$c->stash->{groups}}, $currentGroup;
        }

        my $language = {};
        $language->{script} = defined $release->GetScript ? $release->GetScript->GetName : "";
        $language->{language} = defined $release->GetLanguage ? $release->GetLanguage->GetName : "";
        $language->{shortLanguage} = defined $release->GetLanguage ? $release->GetLanguage->GetISOCode3T : "";

        my $rel = MusicBrainz::Server::Controller::Release::releaseLink($release);
        $rel->{trackCount} = $release->GetTrackCount;
        $rel->{discIds} = $release->GetDiscidCount;
        $rel->{puids} = $release->GetPuidCount;
        $rel->{quality} = ModDefs::GetQualityText($release->GetQuality);
        $rel->{language} = $language;
        $rel->{status} = $release->GetAttributeName($status);
        $rel->{releaseDate} = $release->GetFirstReleaseDateYMD;

        $rel->{attributes} = [];
        my $attributes = $release->GetAttributes;

        for my $attr ($attributes)
        {
            push @{$rel->{attributes}}, $release->GetAttributeName($attr);
        }

        push @{$currentGroup->{releases}}, $rel;
    }

    # Decide how to display the data
    if ($c->request->params->{full})
    {
        $c->stash->{template} = 'artist/full.tt';
    }
    else
    {
        $c->stash->{template} = 'artist/compact.tt';
    }
}

sub LoadArtistTags
{
    my ($dbh, $tagCount, $artist) = @_;

    my $t = MusicBrainz::Server::Tag->new($dbh);
    my $tagHash = $t->GetTagHashForEntity('artist', $artist->GetId, $tagCount + 1);

    sort { $tagHash->{$b} <=> $tagHash->{$a}; } keys %{$tagHash};
}

sub LoadArtistARLinks
{
    my ($dbh, $artist) = @_;
    my @arLinks;

    my $link = MusicBrainz::Server::Link->new($dbh);
    @arLinks = $link->FindLinkedEntities($artist->GetId,
        'artist', to_type => ['label', 'url', 'artist']);

    my $max = scalar(@arLinks);
    my ($item, $i);

    for($i = 0; $i < $max; $i++)
    {
        $item = $arLinks[$i];
		if ($item->{link0_type} ne 'artist' || $item->{link0_id} != $artist->GetId)
		{
			@$item{qw(
                link0_type			link1_type
                link0_id			link1_id
                link0_name			link1_name
                link0_sortname		link1_sortname
                link0_resolution	link1_resolution
                link0_mbid          link1_mbid
                link_phrase			rlink_phrase
			)} = @$item{qw(
                link1_type			link0_type
                link1_id			link0_id
                link1_name			link0_name
                link1_sortname		link0_sortname
                link1_resolution	link0_resolution
                link1_mbid          link0_mbid
                rlink_phrase		link_phrase
			)};
		}
	}

    sort
    {
        my $c = $a->{link_phrase} cmp $b->{link_phrase};
        return $c if ($c);
        
        $c = $a->{enddate} cmp $b->{enddate};
        return $c if ($c);

        $c = $a->{begindate} cmp $b->{begindate};
        return $c if ($c);
		
        return $a->{link1_name} cmp $b->{link1_name};
    } @arLinks;
}

sub LoadArtistReleases
{
    my $artist = shift;

    my @releases = $artist->GetReleases(1, 1);
    my $onlyHasVAReleases = (scalar @releases) == 0;

    my @shortList;

    for my $release (@releases)
    {
        my ($type, $status) = $release->GetReleaseTypeAndStatus;

        # Construct values to sort on
        $release->SetMultipleTrackArtists($release->GetArtist != $release->GetId() ? 1 : 0);
        $release->{_is_va_} = ($release->GetArtist == &ModDefs::VARTIST_ID or
                               $release->GetArtist != $release->GetId());
        $release->{_is_nonalbum_} = ($type == MusicBrainz::Server::Release::RELEASE_ATTR_NONALBUMTRACKS);
        $release->{_section_key_} = ($release->{_is_va_} . " " . $type);
        $release->{_name_sort_} = lc decode "utf-8", $release->GetName;
        $release->{_disc_max_} = 0;
        $release->{_disc_no_} = 0;
        $release->{_firstreleasedate_} = ($release->GetFirstReleaseDate || "9999-99-99");

        CheckAttributes($release);

        # Attempt to sort "disc x [of y]" correctly
        if ($release->{_name_sort_} =~
            /^(.*)                              # $1 <main title>
                (?:[(]disc\ (\d+)               # $2 (disc x
                    (?:\ of\ (\d+))?            # $3 [of y]
                    (?::[^()]*                  #    [: <disc title>
                        (?:[(][^()]*[)][^()]*)* #     [<1 level of nested par.>]
                    )?                          #    ]
                    [)]                         #    )
                )
                (.*)$                           # $4 [<rest of main title>]
            /xi)
        {
            $release->{_name_sort_} = "$1 $4";
            $release->{_disc_no_} = $2;
            $release->{_disc_max_} = $3 || 0;
        }

        # Push onto our list of releases we are actually interested in
        push @shortList, $release
            if ($type == MusicBrainz::Server::Release::RELEASE_ATTR_ALBUM ||
                $type == MusicBrainz::Server::Release::RELEASE_ATTR_EP ||
                $type == MusicBrainz::Server::Release::RELEASE_ATTR_COMPILATION ||
                $type == MusicBrainz::Server::Release::RELEASE_ATTR_SINGLE);
    }

    sort SortAlbums @shortList;
}

sub CheckAttributes
{
    my ($a) = @_;

    for my $attr ($a->GetAttributes)
    {
        $a->{_attr_type} = $attr if ($attr >= MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_TYPE_START &&
                                     $attr <= MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_TYPE_END);
        $a->{_attr_status} = $attr if ($attr >= MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_STATUS_START &&
                                       $attr <= MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_STATUS_END);
        $a->{_attr_type} = $attr if ($attr == MusicBrainz::Server::Release::RELEASE_ATTR_NONALBUMTRACKS);
    }

    # The "actual values", used for display
    $a->{_actual_attr_type} = $a->{_attr_type};
    $a->{_actual_attr_status} = $a->{_attr_status};

    # Used for sorting
    $a->{_attr_type} = MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_TYPE_END + 1
        if (not defined $a->{_attr_type});
    $a->{_attr_status} = MusicBrainz::Server::Release::RELEASE_ATTR_SECTION_STATUS_END + 1
        if (not defined $a->{_attr_status});
};

=head2 SortAlbums

Sort a list of MusicBrainz::Server::Album objects into the order they are displayed on the
artist homepage

=cut

sub SortAlbums
{
    # I edited these out of one huge "or"ed conditional as it was a bitch to debug
    my @predicates = (
        ($a->{_is_va_} <=> $b->{_is_va_}),
        ($b->{_is_nonalbum_} <=> $a->{_is_nonalbum_}),
        ($a->{_attr_type} <=> $b->{_attr_type}),
        ($a->{_firstreleasedate_} cmp $b->{_firstreleasedate_}),
        ($a->{_name_sort_} cmp $b->{_name_sort_}),
        ($a->{_disc_max_} <=> $b->{_disc_max_}),
        ($a->{_disc_no_} <=> $b->{_disc_no_}),
        ($a->{_attr_status} <=> $b->{_attr_status}),
        ($a->{trackcount} cmp $b->{trackcount}),
        ($b->{trmidcount} cmp $a->{trmidcount}),
        ($b->{puidcount} cmp $a->{puidcount}),
        ($a->GetId cmp $b->GetId)
    );
    

    for my $pred (@predicates)
    {
        return $pred if ($pred);
    }

    0;
};

=head1 AUTHOR

Oliver Charles <oliver.g.charles@googlemail.com>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;