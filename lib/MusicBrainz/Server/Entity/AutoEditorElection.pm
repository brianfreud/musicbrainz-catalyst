package MusicBrainz::Server::Entity::AutoEditorElection;
use Moose;

use MooseX::AttributeHelpers;
use MusicBrainz::Server::Entity::Types;
use MusicBrainz::Server::Types qw( :election_status );

extends 'MusicBrainz::Server::Entity::Entity';

has [qw( candidate proposer seconder_1 seconder_2 )] => (
    isa => 'Editor',
    is  => 'rw',
);

has [qw( candidate_id proposer_id seconder_1_id seconder_2_id)] => (
    isa => 'Int',
    is  => 'rw',
);

has 'status' => (
    isa => 'AutoEditorElectionStatus',
    is  => 'rw'
);

has 'yes_votes' => (
    metaclass => 'Counter',
    isa       => 'Int',
    is        => 'rw',
    provides  => {
        inc => '_inc_yes',
    },
    default   => 0,
);

has 'no_votes' => (
    metaclass => 'Counter',
    isa       => 'Int',
    is        => 'rw',
    provides  => {
        inc => '_inc_no'
    },
    default   => 0,
);

has [qw( propose_time open_time close_time )] => (
    isa => 'DateTime',
    is  => 'rw',
);

has 'votes' => (
    isa  => 'ArrayRef[AutoEditorElectionVote]',
    is   => 'rw',
);

sub is_open
{
    my $self = shift;
    return $self->status == $ELECTION_OPEN;
}

sub is_pending
{
    my $self = shift;
    return $self->status == $ELECTION_SECONDER_1 ||
           $self->status == $ELECTION_SECONDER_2;
}

sub is_closed
{
    my $self = shift;
    return $self->status == $ELECTION_ACCEPTED ||
           $self->status == $ELECTION_REJECTED ||
           $self->status == $ELECTION_CANCELLED;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

MusicBrainz::Server::Entity::AutoEditorElection - an auto-editor
election

=head1 DESCRIPTION

MusicBrainz allows certain editors to become auto-editors via an
elective process, from other members of the community. This entity
represents one of these elections

=head1 ATTRIBUTES

=head2 candidate

The editor proposed to become an auto-editor

=head2 proposer, seconder_1, seconder_2

The editor's who proposed and seconded this election, respectively.
The latter 2 may be undef.

=head2 status

The current status of this election, see L<MusicBrainz::Server::Types>
for possible values.

=head2 yes_votes, no_votes

The amount of yes and no votes this election has received, respectively.

=head2 propose_time, open_time, close_time

The time this election was proposed, opened for voting and closed.
open_time and close_time my be undef, depending on the status of the
election.

=head2 votes

A list of all votes cast in this election.

=head1 METHODS

=head2 Status helpers

=head3 is_open

Check if this election is open for voting

=head3 is_closed

Check if this election has been closed

=head3 is_pending

Check if this election is waiting for other editors to second it.

=head1 COPYRIGHT

Copyright (C) 2009 Oliver Charles

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
