#!/home/httpd/musicbrainz/mb_server/cgi-bin/perl -w
# vi: set ts=4 sw=4 :
#____________________________________________________________________________
#
#   MusicBrainz -- the open internet music database
#
#   Copyright (C) 2000 Robert Kaye
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   $Id$
#____________________________________________________________________________

use strict;
use warnings;

package MusicBrainz::Server::ModBot;

use ModDefs qw( :modstatus );

# This is a placeholder that the Moderation Bot will use to evaluate mods.
# The user should never see this state.
use constant STATUS_EVALNOCHANGE         => -1;

# Originally this was part of "Moderation.pm", but I feel it's large and
# complex enough to move into a file of its own.

my $fDryRun = 0;
my $fDebug = 0;
my $fSummary = 0;
my $fVerbose = 0;

sub new
{
	my ($class, $dbh) = @_;
	bless {
		DBH => $dbh,
	}, ref($class) || $class;
}

# Go through the Moderation table and evaluate open Moderations

sub CheckModerations
{
	my $this = shift;

	use Getopt::Long;
	GetOptions(
		"dryrun|d"	=> \$fDryRun,
		"debug"		=> \$fDebug,
		"summary|s"	=> \$fSummary,
		"verbose|v"	=> \$fVerbose,
	) or return 1;

	die "Unknown arguments passed to ModBot" if @ARGV;

	print localtime() . " : ModBot starting\n"
		if $fVerbose;

	local $| = 1;

   if (&DBDefs::DB_READ_ONLY)
   {
	   print localtime() . " : ModBot bailing out because DB_READ_ONLY is set\n";
	   return 0;
   }

	require Moderation;
	my $basemod = Moderation->new($this->{DBH});

	print localtime() . " : Finding open and to-be-deleted moderations ...\n"
		if $fVerbose;

	my $sql = Sql->new($this->{DBH});
	$sql->Select(
		"SELECT id FROM moderation_open ORDER BY id",
	);

	# A cache of subscribers to each artist.  Saves us repeatedly fetching the
	# subscribers for the same artist, as there are likely to be several mods
	# per artist.
	my %artist_subscribers;

	# Fetch each moderation in the set and put it into the %mods hash (keyed
	# by moderation ID).  Then determine the mod's new status, and save that
	# in the key "__eval__".
	my %mods;

	while (my @row = $sql->NextRow())
	{
		my $mod = $basemod->CreateFromId($row[0]);

       if (!defined $mod)
       {
           print STDERR "Cannot create moderation $row[0]. This " .
                        "moderation will remain open.\n";
           next;
       }

       # Save the loaded modules for later
       $mod->{__eval__} = $mod->GetStatus();
       $mods{$row[0]} = $mod;

		print localtime() . " : Evaluate Mod: " . $mod->GetId() . "\n"
			if $fDebug;

       # See if this mod has been marked for deletion
       if ($mod->GetStatus() == STATUS_TOBEDELETED)
       {
           # Change the status to deleted. 
			print localtime() . " : EvalChange: $mod->{id} to be deleted\n"
				if $fDebug;
           $mod->{__eval__} = STATUS_DELETED;
           next;
       }

       # See if a KeyValue mod is pending for this.
       if ($this->CheckModificationForFailedDependencies($mod, \%mods) == 0)
       {
			print localtime() . " : EvalChange: kv dep failed\n"
				if $fDebug;
           # If the prereq. change failed, close this modification
           $mod->{__eval__} = STATUS_FAILEDPREREQ;
           next;
       }

       # Check to see if this change has another change that it depends on
       if (defined $mod->GetDepMod() && $mod->GetDepMod() > 0)
       {
           my $depmod;

           # Get the status of the dependent change. Since all open mods
           # have been loaded (or in this case, all preceding mods have
           # already been loaded) check to see if the dep mod around.
           # If not, its been closed. If so, check its status directly.
           $depmod = $mods{$mod->GetDepMod()};
           if (defined $depmod)
           {
				print localtime() . " : DepMod status: " . $depmod->{__eval__} . "\n"
					if $fDebug;
              # We have the dependant change in memory
              if ($depmod->{__eval__} == STATUS_OPEN ||
                  $depmod->{__eval__} == STATUS_EVALNOCHANGE)
              {
					print localtime() . " : EvalChange: Memory dep still open\n"
						if $fDebug;

                  # If the prereq. change is still open, skip this change 
                  $mod->{__eval__} = STATUS_EVALNOCHANGE;
                  next;
              }
              elsif ($depmod->{__eval__} != STATUS_APPLIED)
              {
					print localtime() . " : EvalChange: Memory dep failed\n"
						if $fDebug;
                  $mod->{__eval__} = STATUS_FAILEDPREREQ;
                  next;
              }
           }
           else
           {
              # If we can't find it, we need to load the status by hand.
              my $dep_status = $this->GetModerationStatus($mod->GetDepMod());
              if ($dep_status != STATUS_APPLIED)
              {
					print localtime() . " : EvalChange: Disk dep failed\n"
						if $fDebug;
                  # The depedent moderation had failed. Fail this one.
                  $mod->{__eval__} = STATUS_FAILEDPREREQ;
                  next;
              }
           }
       }

       # Has the vote period expired and there have been votes?
       if ($mod->GetExpired() &&
          ($mod->GetYesVotes() > 0 || $mod->GetNoVotes() > 0))
       {
           # Are there more yes votes than no votes?
           if ($mod->GetYesVotes() < $mod->GetNoVotes())
           {
				#print localtime () . " : EvalChange: expire and voted down\n"
				#	if $fDebug;
               $mod->{__eval__} = STATUS_FAILEDVOTE;
               next;
           }
			print localtime() . " : EvalChange: expire and approved\n"
				if $fDebug;
           $mod->{__eval__} = STATUS_APPLIED;
           next;
       }

       # Are the number of required unanimous votes present?
       if ($mod->GetYesVotes() >= &DBDefs::NUM_UNANIMOUS_VOTES && 
           $mod->GetNoVotes() == 0)
       {
			print localtime() . " : EvalChange: unanimous yes\n"
				if $fDebug;
           # A unanimous yes. 
           $mod->{__eval__} = STATUS_APPLIED;
           next;
       }

       if ($mod->GetNoVotes() >= &DBDefs::NUM_UNANIMOUS_VOTES && 
           $mod->GetYesVotes() == 0)
       {
			print localtime() . " : EvalChange: unanimous no\n"
				if $fDebug;
           # A unanimous no.
           $mod->{__eval__} = STATUS_FAILEDVOTE;
           next;
       }


		# At this point all expired votes have been applied if someone has
		# voted on them.

		# grace period exceeded, nobody voted on it
		if ($mod->GetGracePeriodExpired)
		{
			print localtime() .
			" : EvalChange: grace period exceeded, approved\n"
				if $fDebug;

		 	$mod->{__eval__} = STATUS_APPLIED;
		  	next;
		}

		# If the mod has expired, see if anyone (other than the moderator) is
		# subscribed to the artist.  If so, allow the mod to stay open a
		# little longer.
		if ($mod->GetExpired)
		{
			my $subscribers = $artist_subscribers{$mod->GetArtist} ||= do {
				require UserSubscription;
				my $us = UserSubscription->new($this->{DBH});
				$us->GetSubscribersForArtist($mod->GetArtist);
			};

			# Any subscribers other than the original moderator?
			my @other_subscribers = grep { $_ != $mod->GetModerator } @$subscribers;

		 	# mod has expired, artist has no subscribers
		  	if (not @other_subscribers)
		   	{
				print localtime() .	" : EvalChange: no subscribers, expired, approved\n"
					if $fDebug;
			   
				$mod->{__eval__} = STATUS_APPLIED;
				next;
			}
		}
	   
		print localtime() . " : EvalChange: no change\n"
			if $fDebug;

       # No condition for this moderation triggered. Leave it alone
       $mod->{__eval__} = STATUS_EVALNOCHANGE;
	}

	$sql->Finish;

	# Now we've decided each moderation's fate, update the database as
	# appropriate.

	my %count;
	my %failedcount;
	my %status_name_from_number = reverse %{ ModDefs::status_as_hashref() };
	my $errors = 0;

	# This sub will be used to report any errors we encounter.
	my $report_error = sub {
		my ($err, $mod, $actiondesc) = @_;

		printf STDERR "%s : An error occurred while trying to set mod #%d to %s (%s).  The error was:\n",
			scalar(localtime),
			$mod->GetId,
			$status_name_from_number{ $mod->{__eval__} },
			$actiondesc;

		chomp $err;
		print STDERR $err, "\n";

		unless (eval { $sql->Rollback; 1 })
		{
			chomp $@;
			print STDERR localtime() . " : Additionally, the ROLLBACK failed ($@)\n";
		}

		print STDERR localtime() . " : The moderation will remain open.\n";

		++$failedcount{ $mod->{__eval__} };
		++$errors;
   };

   # Now run through each mod and do whatever's necessary; namely, nothing,
   # approve, deny, or delete.
	require UserStuff;
	my $user = UserStuff->new($this->{DBH});

   foreach my $key (reverse sort { $a <=> $b} keys %mods)
   {
       print localtime() . " : Check mod: $key\n" if $fDebug;

       my $mod = $mods{$key};
	   my $newstate = $mod->{__eval__};
	   ++$count{$newstate};

       if ($newstate == STATUS_APPLIED)
       {
			print localtime() . " : Applying mod #" . $mod->GetId . "\n"
				if $fVerbose;
			next if $fDryRun;

           eval
           {
               my $status;

               $sql->Begin;

               $status = $mod->ApprovedAction;
               $mod->SetStatus($status);
               $user->CreditModerator($mod->GetModerator, $status);
               $mod->CloseModeration($status);

               $sql->Commit;
           };

		   $report_error->($@, $mod, "approve") if $@;
		   next;
       }

       if ($newstate == STATUS_DELETED)
       {
			print localtime() . " : Deleting mod #" . $mod->GetId() . "\n"
				if $fVerbose;
			next if $fDryRun;

           eval
           {
               $sql->Begin;

               $mod->SetStatus(STATUS_DELETED);
               $mod->DeniedAction;
               $mod->CloseModeration(STATUS_DELETED);

               $sql->Commit;
           };

		   $report_error->($@, $mod, "delete") if $@;
		   next;
       }
       
       if ($newstate != STATUS_EVALNOCHANGE)
       {
			print localtime() . " : Denying mod #" . $mod->GetId()
				. " (". $status_name_from_number{$newstate} . ")\n"
				if $fVerbose;
			next if $fDryRun;

           eval
           {
               $sql->Begin;

               $mod->DeniedAction;
               $user->CreditModerator($mod->GetModerator, $newstate);
               $mod->CloseModeration($newstate);

               $sql->Commit;
           };

		   $report_error->($@, $mod, "deny") if $@;
		   next;
       }

	   # Otherwise: no change.  Check to see if the moderation should remain
	   # open.
	   {
			print localtime() . " : Checking mod #" . $mod->GetId()
				. " prerequisites\n"
				if $fDebug;
			next if $fDryRun;

			eval
			{
				$sql->Begin;

				my $status = $mod->CheckPrerequisites;
				if (defined $status)
				{
					print localtime() . " : Closing mod #" . $mod->GetId()
						. " (" . $status_name_from_number{$status} . ")\n";

					++$count{$status};
					$mod->DeniedAction;
					$mod->CloseModeration($status);
				}

				$sql->Commit;
			};

	 		$report_error->($@, $mod, "deny") if $@;
	 		next;
	   }
   }

	# All done.  Print a summary if one was requested.

	if ($fSummary)
	{
		print localtime() . " : Summary:\n";

		for my $statnum (sort { $a <=> $b } keys %status_name_from_number)
		{
			my $count = $count{$statnum} or next;
			my $statname = $status_name_from_number{$statnum};

			printf "%s :   %-20.20s %5d",
				scalar localtime(), $statname, $count;

			my $f = $failedcount{$statnum};
			print " ($f failed)" if $f;

			print "\n";
		}

		print localtime() . " :   There were no moderations!\n"
			if not keys %count;
	}

	print localtime() . " : ModBot completed\n"
		if $fVerbose;

	# Exit with a failure code if any errors were encountered
	($errors ? 3 : 0);
}

# Check a given moderation for any dependencies that may have not been met
sub CheckModificationForFailedDependencies
{
   my ($this, $mod, $modhash) = @_;
   my ($sql, $status, $i, $depmod); 

   $sql = Sql->new($this->{DBH});
   for($i = 0;; $i++)
   {
       # FIXME this regex looks too slack for my liking
       if ($mod->GetNew() =~ m/Dep$i=(.*)/m)
       {
           #print localtime() . " : Mod: " . $mod->GetId() . " depmod: $1\n"
		   #	if $fDebug;
           $depmod = $modhash->{$1};
           if (defined $depmod)
           {
              $status = $depmod->{__eval__};
           }
           else
           {
			   $status = $this->GetModerationStatus($1);
           }
           if (!defined $status || 
               $status == STATUS_FAILEDVOTE ||
               $status == STATUS_FAILEDDEP ||
               $status == STATUS_DELETED)
           {
              return 0;
           }
       }
       else
       {
           last;
       }
   }
    
   return 1;
}

sub GetModerationStatus
{
 	my ($this, $id) = @_;
	my $sql = Sql->new($this->{DBH});

	my $status = $sql->SelectSingleValue(
		"SELECT status FROM moderation_all WHERE id = ?",
		$id,
	);

	defined($status) ? $status : STATUS_ERROR;
}

1;
# eof ModBot.pm
