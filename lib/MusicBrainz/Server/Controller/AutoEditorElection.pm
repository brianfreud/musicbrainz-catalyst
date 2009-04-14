package MusicBrainz::Server::Controller::AutoEditorElection;

use strict;
use warnings;

use base 'MusicBrainz::Server::Controller';

use Exception::Class;
use MusicBrainz::Server::Form::AutoEditorElection::Propose;

__PACKAGE__->config(namespace => 'elections');

sub elections : Path('') Form('AutoEditorElection::Propose')
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

sub propose : Local Form('AutoEditorElection::Propose')
{
    my ($self, $c) = @_;
    
    return unless $self->submit_and_validate($c);

    my $form = $self->form;
    my $editor = $c->model('User')->load({ username => $form->value('editor') });

    my $election;
    eval {
        $election = $c->model('AutoEditorElection')->propose($editor, $c->user);
    };

    if (my $e = Exception::Class->caught('AlreadyAutoEditorException'))
    {
        $form->field('editor')->add_error('This editor is already an auto-editor.');
    }
    elsif (my $e = Exception::Class->caught('EditorIneligibleException'))
    {
        $form->field('editor')->add_error('This editor is ineligible to become an auto-editor.');
    }
    elsif (my $e = Exception::Class->caught('ElectionAlreadyExistsException'))
    {
        $c->response->redirect($c->uri_for('/elections', $e->election_id));
    }
    else
    {
        $c->stash->{election_id} = $election->id;
        $c->stash->{candidate} = $editor;
        $c->stash->{template} = 'elections/proposed.tt';
    }
}

sub login : Private
{
    my ($self, $c) = @_;
    $c->forward('/user/login');

    if (!$c->user->is_auto_editor)
    {
        $c->stash->{template} = 'elections/no_privs.tt';
        $c->detach;
    }
}

1;