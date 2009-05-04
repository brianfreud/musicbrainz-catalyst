#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 11;

BEGIN {
    use_ok 'MusicBrainz::Server::Entity::AutoEditorElection';
    use_ok 'MusicBrainz::Server::Entity::AutoEditorElectionVote';
}

use MusicBrainz::Server::Types qw( :election_status :vote );
use MusicBrainz::Server::Entity::Editor;

my $election = MusicBrainz::Server::Entity::AutoEditorElection->new;
ok(defined $election, "constructor");
isa_ok($election, 'MusicBrainz::Server::Entity::AutoEditorElection', 'isa');
can_ok($election, qw( id candidate proposer seconder_1 seconder_2 status
                      yes_votes no_votes propose_time close_time open_time ));

my $yes_vote = MusicBrainz::Server::Entity::AutoEditorElectionVote->new(
    vote => $VOTE_YES
);

my $no_vote = MusicBrainz::Server::Entity::AutoEditorElectionVote->new(
    vote => $VOTE_NO
);

my $other_vote = MusicBrainz::Server::Entity::AutoEditorElectionVote->new(
    vote => $VOTE_ABSTAIN
);

ok($yes_vote->is_yes);
ok(!$yes_vote->is_no);

ok(!$no_vote->is_yes);
ok($no_vote->is_no);

ok(!$other_vote->is_yes);
ok(!$other_vote->is_no);

