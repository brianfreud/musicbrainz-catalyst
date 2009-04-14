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

    $c->stash->{elections} = $c->model('AutoEditorElection')->elections(
        with_candidate => 1
    );
}

sub details : Path('') Args(1)
{
    my ($self, $c, $election) = @_;

    $c->stash->{election} = $election =
        $c->model('AutoEditorElection')->new_from_id($election, with_editors => 1)
        or $c->detach('/error_404');

    $c->stash->{votes} = $election->votes(with_voters => 1);
}

sub cancel : Local Args(1)
{
    my ($self, $c, $election) = @_;
    $c->forward('login');

    if (!$c->form_posted)
    {
        # Require POST as this action is non-idempotent
        $c->response->redirect($c->uri_for('/elections', $election));
        $c->detach;
    }

    eval {
        $election = $c->model('AutoEditorElection')->new_from_id($election);
        $election->cancel($c->user)
    };

    if (my $e = Exception::Class->caught('EditorIneligibleException'))
    {
        $c->stash(
            template => 'elections/problem.tt',
            message  => 'You may not cancel elections you did not propose'
        );
    }
    elsif (my $e = Exception::Class->caught('ElectionClosedException'))
    {
        $c->stash(
            template => 'elections/problem.tt',
            message  => 'This election has already been closed'
        );
    }
    else
    {
        $c->response->redirect($c->uri_for('/elections', $election));
    }
}

sub propose : Local Form('AutoEditorElection::Propose')
{
    my ($self, $c) = @_;
    $c->forward('login');
    
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