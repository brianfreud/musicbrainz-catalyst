#!/usr/bin/perl -w
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

package MusicBrainz::Server::Moderation::MOD_EDIT_LINK_ATTR;

use ModDefs qw( :modstatus DARTIST_ID MODBOT_MODERATOR );
use base 'Moderation';

sub Name { "Edit Link Attribute" }
(__PACKAGE__)->RegisterHandler;

sub PreInsert
{
	my ($self, %opts) = @_;

	my $node = $opts{'node'} or die; # a LinkType object
	my $name = $opts{'name'};
	my $desc = $opts{'description'};

	MusicBrainz::TrimInPlace($name);
	die if $name eq "";

	my $c = $node->Parent->GetNamedChild($name);
	if ($c and $c->GetId != $node->GetId)
	{
		my $note = "There is already an attribute called '$name' here";
		$self->SetError($note);
		die $self;
	}

	$self->SetArtist(DARTIST_ID);
	$self->SetTable($node->{_table});
	$self->SetColumn("name");
	$self->SetRowId($node->GetId);
	$self->SetPrev($node->GetName . " (" . $node->GetDescription . ")");

	my %new = (
		name        => $name,
		desc        => $desc,
	);

	$node->SetName($name);
	$node->SetDescription($desc);
	$node->Update;

	$self->SetNew($self->ConvertHashToNew(\%new));
}

sub PostLoad
{
	my $self = shift;
	$self->{'new_unpacked'} = $self->ConvertNewToHash($self->GetNew)
		or die;
}

# Since I changed this to by an auto mod type, I think this entire block is useless, right?
sub DeniedAction
{
  	my $self = shift;

	my $status = $self->CheckPrerequisites;
	return $status if $status;

	my $link = MusicBrainz::Server::LinkType->new(
		$self->{DBH},
	);

	my $node = $link->newFromId($self->GetRowId);
	if (not $node)
	{
		$self->InsertNote(MODBOT_MODERATOR, "This link attribute has been deleted");
		return;
	}

	my $name = $self->GetPrev;
	my $c = $node->Parent->GetNamedChild($name);
	if ($c and $c->GetId != $node->GetId)
	{
		$self->InsertNote(MODBOT_MODERATOR, "There is already a link attribute called '$name' here");
		return;
	}

	$node->SetName($name);
	$node->Update;
}

1;
# eof MOD_EDIT_LINK_ATTR.pm