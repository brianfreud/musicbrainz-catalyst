package MusicBrainz::Server::Model::AutoEditorElection;

use strict;
use warnings;

use base 'Catalyst::Model::Factory::PerRequest';

__PACKAGE__->config(class => 'MusicBrainz::Server::AutoEditorElection');

sub prepare_arguments
{
    my ($self, $c) = @_;
    return $c->mb->dbh;
}

1;