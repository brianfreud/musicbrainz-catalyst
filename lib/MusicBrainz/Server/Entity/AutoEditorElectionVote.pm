package MusicBrainz::Server::Entity::AutoEditorElectionVote;
use Moose;

use MusicBrainz::Server::Entity::Types;
use MusicBrainz::Server::Types qw( :vote );

extends 'MusicBrainz::Server::Entity::Entity';

has 'election' => (
    isa => 'AutoEditorElection',
    is  => 'rw',
);

has 'voter' => (
    isa => 'Editor',
    is  => 'rw',
);

has [qw( election_id voter_id )] => (
    isa => 'Int',
    is  => 'rw'
);

has 'vote_time' => (
    isa => 'DateTime',
    is  => 'rw',
);

has 'vote' => (
    isa => 'Vote',
    is  => 'rw'
);

sub is_yes
{
    return shift->vote == $VOTE_YES;
}

sub is_no
{
    return shift->vote == $VOTE_NO;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

MusicBrainz::Server::Entity::AutoEditorElectionVote - a vote on an
auto-editor election

=head1 DESCRIPTION

This represents a single editors vote cast on an auto-editor election.

=head1 ATTRIBUTES

=head2 election

The election this vote is cast on

=head2 editor

The editor who cast the vote

=head2 vote

The vote. See L<MusicBrainz::Server::Types/Vote>.

=head2 vote_time

The time the vote was registered

=head1 METHODS

=head2 is_yes, is_no

Check if the vote was a yes or no vote. Note, these may both be fault
if the vote was an abstained vote.

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
