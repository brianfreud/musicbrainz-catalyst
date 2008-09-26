package MusicBrainz::Server::Form::Field::Track;

use strict;
use warnings;

use base 'MusicBrainz::Server::Form::Field::Compound';

use Rose::Object::MakeMethods::Generic(
    boolean => [ with_track_number => { default => 1 } ],
);

=head1 NAME

MusicBrainz::Server::Form::Field::Track

=head1 DESCRIPTION

Provides a compound field that supports track number, title and duration

=head1 METHODS

=head2 init_widget

This field has type 'track' - which we specialise on in forms/input.tt
to draw the 3 separate input fields

=cut

sub profile
{
    my $self = shift;

    my $profile = {
        required => {
            name   => 'Text',
            duration => '+MusicBrainz::Server::Form::Field::Time',
        },
        optional => {
        }
    };

    if ($self->with_track_number)
    {
        $profile->{required}->{number} = '+MusicBrainz::Server::Form::Field::TrackNumber',
    }

    return $profile;
}

1;
