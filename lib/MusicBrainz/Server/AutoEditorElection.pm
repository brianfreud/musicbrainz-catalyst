package MusicBrainz::Server::AutoEditorElection;
use Moose;
extends 'TableBase';

use Moose::Util::TypeConstraints;

use Carp;
use ModDefs ':vote';
use ModDefs ':userid';
use MusicBrainz::Server::Editor;

use constant PROPOSAL_TIMEOUT => "1 week";
use constant VOTING_TIMEOUT   => "1 week";

our $STATUS_AWAITING_SECONDER_1	= 1;
our $STATUS_AWAITING_SECONDER_2	= 2;
our $STATUS_VOTING_OPEN			= 3;
our $STATUS_ACCEPTED			= 4;
our $STATUS_REJECTED			= 5;
our $STATUS_CANCELLED			= 6;

my %descstatus = (
	$STATUS_AWAITING_SECONDER_1	=> "awaiting 1st seconder",
	$STATUS_AWAITING_SECONDER_2	=> "awaiting 2nd seconder",
	$STATUS_VOTING_OPEN			=> "voting open",
	$STATUS_ACCEPTED			=> "accepted",
	$STATUS_REJECTED			=> "declined",
	$STATUS_CANCELLED			=> "cancelled",
);

subtype 'MusicBrainz.Editor' => as class_type('MusicBrainz::Server::Editor');
coerce 'MusicBrainz.Editor'
    => from 'Int'
        => via { MusicBrainz::Server::Editor->new(undef, id => $_) };

has [qw/candidate proposer seconder1 seconder2/] => (
    is  => 'ro',
    isa => 'MusicBrainz.Editor',
    coerce => 1,
    trigger => \&_set_user_dbh
);

sub _set_user_dbh
{
    my ($self, $user) = @_;
    $user->dbh($self->dbh);
}

has 'status' => (
    is => 'ro'
);

has 'yes_votes' => (
    is => 'ro',
    init_arg => 'yesvotes',
);

has 'no_votes' => (
    is => 'ro',
    init_arg => 'novotes'
);

has 'proposed_at' => (
    is => 'ro',
    init_arg => 'proposetime',
);

has 'opened_at' => (
    is => 'ro',
    init_arg => 'opentime'
);

has 'closed_at' => (
    is => 'ro',
    init_arg => 'closetime'
);

=head2 elections

Get a list of all auto-editor elections, order in descednding order of the
the election was proposed.

Returns an array reference of MusicBrainz::Server::AutoEditorElections

=cut

sub elections
{
    my $self = shift;
    my $sql = Sql->new($self->dbh);

    my $rows = $sql->SelectListOfHashes(
        "SELECT * FROM automod_election ORDER BY proposetime DESC",
    );

    my @elections = map {
            MusicBrainz::Server::AutoEditorElection->new($self->dbh, $_)
        } @$rows;

    return \@elections;
}

=head2 pending_elections $user

Get a list of all elections in which $user should be reminded to participate.

=cut

sub pending_elections
{
	my ($self, $user) = @_;
	my $sql = Sql->new($self->dbh);

	my $rows = $sql->SelectListOfHashes(qq|
	    SELECT *
	      FROM automod_election
		 WHERE status IN ($STATUS_AWAITING_SECONDER_1,
		                  $STATUS_AWAITING_SECONDER_2,
		                  $STATUS_VOTING_OPEN)
	  ORDER BY proposetime DESC|);

    # Find all elections the user proposed or seconded, but have not voted
    # in
    my @elections;
    my $uid = $user->id;
	for (@$rows)
	{
	    my $el = MusicBrainz::Server::AutoEditorElection->new($self->dbh, $_);
	    
	    next
	        if ($el->proposer->id  == $uid ||
                $el->seconder1->id == $uid ||
                $el->seconder2->id == $uid);

	    for my $vote (@{ $el->votes })
	    {
	        next if $vote->voter->id == $uid;
	    }

        push @elections, $el;
	}

	return \@elections;
}

sub new_from_id
{
	my ($self, $id) = @_;
	my $sql = Sql->new($self->dbh);

	my $row = $sql->SelectSingleRowHash(
	    qq|SELECT * FROM automod_election WHERE id = ?|,
		$id,
	) or return;

    return MusicBrainz::Server::AutoEditorElection->new($self->dbh, $row);
}

sub refresh
{
	my $self = shift;
	my $sql = Sql->new($self->dbh);

	my $newself = $self->new_from_id($self->id)
		or return;

	%$self = %$newself;
	return $self;
}

sub status_name
{
	my ($self, $status) = @_;

	$status = $self->status unless defined $status;
	return $descstatus{$status};
}

sub votes
{
    my ($self) = @_;
	my $sql = Sql->new($self->dbh);

	my $votes = $sql->SelectListOfHashes(
		"SELECT * FROM automod_election_vote WHERE automod_election = ? ORDER BY votetime",
		$self->id,
	);
	
	return [ map {
	    MusicBrainz::Server::AutoEditorElectionVote->new($self->dbh, $_);
	} @$votes ];
}

=head2 close_elections

Automatically close or timeout elections.

=cut

sub close_elections
{
	my $self = shift;
	my $sql = Sql->new($self->dbh);

	$sql->AutoTransaction(
		sub {
			$sql->Do("LOCK TABLE automod_election IN EXCLUSIVE MODE");
			
			my $to_timeout = $sql->SelectListOfHashes(
				"SELECT * FROM automod_election WHERE status IN ($STATUS_AWAITING_SECONDER_1,$STATUS_AWAITING_SECONDER_2)
					AND NOW() - proposetime > INTERVAL ?",
				PROPOSAL_TIMEOUT,
			);

			for my $election (@$to_timeout)
			{
			    $election = MusicBrainz::Server::AutoEditorElection->new($self->dbh, $election);
				$election->_timeout;
			}

			my $to_close = $sql->SelectListOfHashes(
				"SELECT * FROM automod_election WHERE status = $STATUS_VOTING_OPEN
					AND NOW() - opentime > INTERVAL ?",
				VOTING_TIMEOUT,
			);

			for my $election (@$to_close)
			{
			    $election = MusicBrainz::Server::AutoEditorElection->new($self->dbh, $election);
				$election->_close;
			}
		},
	);
}

sub _timeout
{
	my $self = shift;
	my $sql = Sql->new($self->dbh);

	$sql->Do(
		"UPDATE automod_election SET status = $STATUS_REJECTED, closetime = NOW() WHERE id = ?",
		$self->id,
	);

	$self->{status} = $STATUS_REJECTED; # XXX: Fix me - avoiding accessors
	# NOTE closetime not set

	$self->send_timeout_email;
}

=head2 _close

Close an election, depending on the amount of yes or no votes it has received

=cut

sub _close
{
	my $self = shift;
	my $sql = Sql->new($self->dbh);

    # XXX Fix me - avoiding accessors
	$self->{status} = (($self->yes_votes > $self->no_votes) ? $STATUS_ACCEPTED : $STATUS_REJECTED);
	# NOTE closetime not set

	$sql->Do(
		"UPDATE automod_election SET status = ?, closetime = NOW() WHERE id = ?",
		$self->status, $self->id,
	);

	if ($self->status == $STATUS_ACCEPTED)
	{
	    my $candidate = MusicBrainz::Server::Editor->newFromId($self->dbh, $self->candidate);
		$candidate->MakeAutoModerator;

		$self->notify_accepted;
	}
	else
	{
		$self->notify_rejected;
	}
}

################################################################################
# The guts of the system: propose, second, cast vote, cancel
################################################################################

=head2 is_user_eligible $user

Make sure a editor is eligible to become an auto-editor

=cut

sub is_user_eligible
{
	my ($self, $user) = @_;
	return !$user->is_special_editor;
}

sub propose
{
	my ($self, $candidate, $proposer) = @_;
	my $sql = Sql->new($self->dbh);

	$sql->AutoTransaction(sub {
        # Do not allow auto-editors to be propsed
    	AlreadyAutoEditorException->throw
    		if $candidate->is_auto_editor($candidate->privs);

        # Make sure the editor is eligible to be an auto-editor
    	EditorIneligibleException->throw
    		unless $self->is_user_eligible($candidate);

    	$sql->Do("LOCK TABLE automod_election IN EXCLUSIVE MODE");

        # Make sure the editor isn't already being elected
    	my $id = $sql->SelectSingleValue(
    		"SELECT id FROM automod_election WHERE candidate = ?
    			AND status IN ($STATUS_AWAITING_SECONDER_1,$STATUS_AWAITING_SECONDER_2,$STATUS_VOTING_OPEN)",
    		$candidate->id,
    	);
    	ElectionAlreadyExistsException->throw(election_id => $id)
    		if $id;

        # All good, create the election
    	$sql->Do(
    		"INSERT INTO automod_election (candidate, proposer) VALUES (?, ?)",
    		$candidate->id, $proposer->id,
    	);
    });

    my $id = $sql->GetLastInsertId("automod_election");

	$self = $self->new_from_id($id);
	$self->announce;

    return $self;
}

sub second
{
	my ($self, $seconder) = @_;
	my $sql = Sql->new($self->dbh);

	$sql->Do("LOCK TABLE automod_election IN EXCLUSIVE MODE");
	$self->_refresh
		or ElectionDoesNotExistException->throw;

    # Do not allow seconding elections that are already closed
	ElectionClosedException->throw
		if $self->{status} =~ /^($STATUS_ACCEPTED|$STATUS_REJECTED|$STATUS_CANCELLED)$/o;

    # Do not allow seconding elections that are open
	ElectionOpenException->throw
		if $self->{status} == $STATUS_VOTING_OPEN;

    # Do not allow seconding if the seconder has already seconded, or is the candidate
	my $propsec = grep { ($self->{$_} || 0) == $seconder->id }
		qw( proposer seconder_1 seconder_2 candidate );
	EditorIneligibleException->throw
		if $propsec;

	$sql->Do(
		"UPDATE automod_election
			SET seconder_1 = ?, status = $STATUS_AWAITING_SECONDER_2
			WHERE id = ? AND status = $STATUS_AWAITING_SECONDER_1",
		$seconder->id,
		$self->id,
	) and do {
		$self->{seconder1} = $seconder->id;
		$self->{status} = $STATUS_AWAITING_SECONDER_2;
		return $self;
	};

	$sql->Do(
		"UPDATE automod_election
			SET seconder_2 = ?, status = $STATUS_VOTING_OPEN, opentime = NOW()
			WHERE id = ? AND status = $STATUS_AWAITING_SECONDER_2",
		$seconder,
		$self->id,
	) and do {
		$self->{seconder2} = $seconder;
		$self->{status} = $STATUS_VOTING_OPEN;
		$self->SendVotingOpenEmail;
		return $self;
	};

	die;
}

sub vote
{
	my ($self, $voter, $vote) = @_;
	my $sql = Sql->new($self->dbh);

	$sql->Do("LOCK TABLE automod_election, automod_election_vote IN EXCLUSIVE MODE");
	$self->_refresh
		or ElectionDoesNotExistException->throw;

	ElectionClosedException->throw
		if $self->{status} =~ /^($STATUS_ACCEPTED|$STATUS_REJECTED|$STATUS_CANCELLED)$/o;
	ElectionNotReadyException->throw
		if $self->{status} =~ /^($STATUS_AWAITING_SECONDER_1|$STATUS_AWAITING_SECONDER_2)$/o;

	my $propsec = grep { ($self->{$_}||0) == $voter }
		qw( candidate proposer seconder_1 seconder_2 );
	EditorIneligibleException->throw
		if $propsec;

	my $old_vote = $sql->SelectSingleRowHash(
		"SELECT * FROM automod_election_vote
			WHERE automod_election = ? AND voter = ?",
		$self->id,
		$voter->id,
	);

	return 1
		if $old_vote and $old_vote->{vote} == $vote;

	if ($old_vote) {
		$sql->Do(
			"UPDATE automod_election_vote SET vote = ?, votetime = NOW() WHERE id = ?",
			$vote,
			$old_vote->{id},
		);
	} else {
		$sql->Do(
			"INSERT INTO automod_election_vote (automod_election, voter, vote) VALUES (?, ?, ?)",
			$self->id,
			$voter->id,
			$vote,
		);
	}

	my $yesdelta = my $nodelta = 0;
	--$yesdelta if $old_vote and $old_vote->{vote} == &ModDefs::VOTE_YES;
	--$nodelta if $old_vote and $old_vote->{vote} == &ModDefs::VOTE_NO;
	++$yesdelta if $vote == &ModDefs::VOTE_YES;
	++$nodelta if $vote == &ModDefs::VOTE_NO;

	$sql->Do(
		"UPDATE automod_election SET yesvotes = yesvotes + ?,
		novotes = novotes + ? WHERE id = ?",
		$yesdelta,
		$nodelta,
		$self->id,
	);

	return 1;
}

use Exception::Class (
        'AlreadyAutoEditorException',
        'EditorIneligibleException',
        'ElectionAlreadyExistsException' => {
            fields => 'election_id',
        },
        'ElectionDoesNotExistException',
        'ElectionClosedException',
        'ElectionOpenException',
        'ElectionNotReadyException',
    );

sub cancel
{
	my ($self, $canceller) = @_;
	my $sql = Sql->new($self->dbh);

	$sql->Do("LOCK TABLE automod_election IN EXCLUSIVE MODE");
	$self->_refresh
		or ElectionDoesNotExistException->throw;

	EditorIneligibleException->throw
		unless $self->proposer == $canceller;

	ElectionClosedException->throw
		if $self->status =~ /^($STATUS_ACCEPTED|$STATUS_REJECTED|$STATUS_CANCELLED)$/o;

	$sql->Do(
		"UPDATE automod_election
			SET status = $STATUS_CANCELLED, closetime = NOW()
			WHERE id = ? AND status IN ($STATUS_AWAITING_SECONDER_1,$STATUS_AWAITING_SECONDER_2,$STATUS_VOTING_OPEN)",
		$self->id,
	) or die;

	$self->{status} = $STATUS_CANCELLED;
	# NOTE closetime is not set
	$self->notify_cancelled;

	return 1;
}

=head2 announce

Announce the creation of a new auto editor election via email

=cut

sub announce
{
    die "Not yet implemented";
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
