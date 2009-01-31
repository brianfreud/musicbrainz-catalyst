package MusicBrainz::Server::Model::News;

use strict;
use warnings;

use base 'MusicBrainz::Server::Model';

use MusicBrainz::Server::News;

sub upcoming_releases
{
    my ($self, $maxitems, $offset) = @_;

    my $stat = MusicBrainz::Server::News->new($self->dbh);
    return $stat->GetUpcomingReleases($maxitems, $offset);
}

sub recent_releases
{
    my ($self, $maxitems, $offset) = @_;

    my $stat = MusicBrainz::Server::News->new($self->dbh);
    return $stat->GetRecentReleases($maxitems, $offset);
}

sub recently_deceased
{
    my ($self, $maxitems, $offset) = @_;

    my $stat = MusicBrainz::Server::News->new($self->dbh);
    return $stat->GetRecentlyDeceased($maxitems, $offset);
}

sub recently_brokenup
{
    my ($self, $maxitems, $offset) = @_;

    my $stat = MusicBrainz::Server::News->new($self->dbh);
    return $stat->GetRecentlyBrokenUp($maxitems, $offset);
}

1;
