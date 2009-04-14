package MusicBrainz::Server::Controller::AutoEditorElection;

use strict;
use warnings;

use base 'Catalyst::Controller';

__PACKAGE__->config(namespace => 'elections');

sub elections : Path('')
{
    my ($self, $c) = @_;
    $c->forward('/user/login');

    $c->stash->{elections} = $c->model('AutoEditorElection')->elections;

    # Refresh all the candidates so we can display them correctly
    for my $el (@{ $c->stash->{elections}})
    {
        $el->candidate->Refresh;
    }
}

1;