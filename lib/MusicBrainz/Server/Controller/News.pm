package MusicBrainz::Server::Controller::News;

use strict;
use warnings;
use Data::Page;

use base 'MusicBrainz::Server::Controller';

=head1 NAME

MusicBrainz::Server::Controller::News - show database "news" and dashboard information

=head1 DESCRIPTION

Displays music "news" and dashboard

=head1 METHODS

=head2 music_news

Display a page that shows upcoming release, recent releases, recently deceased artist and recently broken up bands.

=cut

sub music_news : Local Arg(1)
{
    my ($self, $c, $type) = @_;

    my $page  = $c->req->query_params->{page} || 1;

    $c->stash->{template} = "news/musicnews.tt";
    if ($type eq 'upcoming_releases')
    {
	my $pager = Data::Page->new;

	($c->stash->{upcoming_releases}, $c->stash->{upcoming_releases_numitems}, $c->stash->{upcoming_releases_timestamp}) =
	    $c->model('News')->upcoming_releases($pager->entries_per_page, ($page - 1) * $pager->entries_per_page);

	$pager->total_entries($c->stash->{upcoming_releases_numitems});
	$pager->entries_per_page(25);
	$pager->current_page($page);
	$c->stash->{pager} = $pager;
    } 
    elsif ($type eq 'recent_releases')
    {
	($c->stash->{recent_releases}, $c->stash->{recent_releases_numitems}, $c->stash->{recent_releases_timestamp}) =
	    $c->model('News')->recent_releases(10, 0);
    } 
    elsif ($type eq 'recently_deceased')
    {
	($c->stash->{recently_deceased}, $c->stash->{recently_deceased_numitems}, $c->stash->{recently_deceased_timestamp}) =
	    $c->model('News')->recently_deceased(10, 0);
    }
    elsif ($type eq 'recently_brokenup')
    {
	($c->stash->{recently_brokenup}, $c->stash->{recently_brokenup_numitems}, $c->stash->{recently_brokenup_timestamp}) =
	    $c->model('News')->recently_brokenup(10, 0);
    }
    else
    {
	($c->stash->{upcoming_releases}, $c->stash->{upcoming_releases_numitems}, $c->stash->{upcoming_releases_timestamp}) =
	    $c->model('News')->upcoming_releases(10, 0);
	($c->stash->{recent_releases}, $c->stash->{recent_releases_numitems}, $c->stash->{recent_releases_timestamp}) =
	    $c->model('News')->recent_releases(10, 0);
	($c->stash->{recently_deceased}, $c->stash->{recently_deceased_numitems}, $c->stash->{recently_deceased_timestamp}) =
	    $c->model('News')->recently_deceased(10, 0);
	($c->stash->{recently_brokenup}, $c->stash->{recently_brokenup_numitems}, $c->stash->{recently_brokenup_timestamp}) =
	    $c->model('News')->recently_brokenup(10, 0);
    } 
}

1;
