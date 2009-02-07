package MusicBrainz::Server::Controller::Doc;
 
use strict;
use warnings;
 
use base 'MusicBrainz::Server::Controller';
 
sub load : Args(1)
{
    my ($self, $c, $page_id) = @_;
 
    my $page = $c->model('Documentation')->fetch_page($page_id);
    $c->stash->{page} = $page;
}
 
sub show : Path('') Args(1)
{
    my ($self, $c) = @_;
 
    $c->forward('load');
 
    my $page = $c->stash->{page};
    $c->stash->{template} = $page->{success} ? 'doc/page.tt'
                          : 'doc/error.tt';
}
 
sub bare : Local Args(1)
{
    my ($self, $c) = @_;
 
    $c->forward('load');
 
    my $page = $c->stash->{page};
    $c->stash->{template} = $page->{success} ? 'doc/bare.tt'
                          : 'doc/bare_error.tt';
}
 
1;
