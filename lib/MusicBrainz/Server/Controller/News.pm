package MusicBrainz::Server::Controller::News;

use strict;
use warnings;

use base 'MusicBrainz::Server::Controller';

=head1 NAME

MusicBrainz::Server::Controller::News - show database "news" and dashboard information

=head1 DESCRIPTION

Displays music "news" and dashboard

=head1 METHODS

=head2 music_news

Display a page that shows upcoming release, recent releases, recently deceased artist and recently broken up bands.

=cut

sub music_news : Local
{
    my ($self, $c) = @_;

    my $type = $c->req->param('type') || '';
    my $maxitems = $c->req->param('maxitems') || 25;
    my $offset = $c->req->param('offset') || 0;

    if ($type eq 'upcoming_releases')
    {
	$c->stash->{template} = "news/musicnews-upcoming_releases.tt";
	($c->stash->{upcoming_releases}, $c->stash->{upcoming_releases_count}, $c->stash->{upcoming_releases_maxitems}) =
	    $c->model('News')->upcoming_releases($maxitems, $offset);
    } 
    elsif ($type eq 'recent_releases')
    {
	$c->stash->{template} = "news/musicnews-recent_releases.tt";
	$c->stash->{recent_releases} = $c->model('News')->recent_releases($maxitems, $offset);
    } 
    elsif ($type eq 'recently_deceased')
    {
	$c->stash->{template} = "news/musicnews-recently_deceased.tt";
	$c->stash->{recently_deceased} = $c->model('News')->recently_deceased($maxitems, $offset);
    }
    elsif ($type eq 'recently_brokenup')
    {
	$c->stash->{template} = "statistics/musicnews-recently_brokenup.tt";
	$c->stash->{recently_brokenup} = $c->model('News')->recently_brokenup($maxitems, $offset);
    }
    else
    {
	$c->stash->{template} = "news/musicnews.tt";
	($c->stash->{upcoming_releases}, $c->stash->{upcoming_releases_count}, $c->stash->{upcoming_releases_maxitems}) =
	    $c->model('News')->upcoming_releases(10, 0);
	($c->stash->{recent_releases}, $c->stash->{recent_releases_count}, $c->stash->{recent_releases_maxitems}) =
	    $c->model('News')->recent_releases(10, 0);
	($c->stash->{recently_deceased}, $c->stash->{recently_deceased_count}, $c->stash->{recently_deceased_maxitems}) =
	    $c->model('News')->recently_deceased(10, 0);
	($c->stash->{recently_brokenup}, $c->stash->{recently_brokenup_count}, $c->stash->{recently_brokenup_maxitems}) =
	    $c->model('News')->recently_brokenup(10, 0);
    } 
}

1;
