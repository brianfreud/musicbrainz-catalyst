package MusicBrainz::Server::Form::Release::Move;

use strict;
use warnings;

use base 'MusicBrainz::Server::Form';

use ModDefs;
use Moderation;

sub profile
{
    return {
        optional => {
            edit_note => 'TextArea',
            move_tracks => 'Checkbox',
        }
    };
}

sub move
{
    my ($self) = @_;

    my $release = $self->item;
    my $user    = $self->context->user;
    my $artist  = $self->context->model('Artist')->load($release->artist);

    my @mods = Moderation->InsertModeration(
        DBH   => $self->context->mb->{DBH},
        uid   => $user->id,
        privs => $user->privs,
        type  => ModDefs::MOD_MOVE_RELEASE,

        album          => $release,
        oldartist      => $artist,
        artistname     => $artist->name,
        artistsortname => $artist->sort_name,
        artistid       => $artist->id,
        movetracks     => $self->value('move_tracks'),
    );

    if (scalar @mods)
    {
        $mods[0]->InsertNote($user->id, $form->value('edit_note'))
            if $mods[0] and $form->value('edit_note') =~ /\S/;
    }

    return \@mods;
}

sub update_from_form
{
    my $self = shift;

    return unless $self->validate(@_);
    $self->update_model;

    return 1;
}

1;