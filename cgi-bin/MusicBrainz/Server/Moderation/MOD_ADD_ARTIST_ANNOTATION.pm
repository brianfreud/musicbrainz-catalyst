#!/usr/bin/perl -w
# vi: set ts=4 sw=4 :
#____________________________________________________________________________
#
#   MusicBrainz -- the open internet music database
#
#   Copyright (C) 2004 Robert Kaye
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

package MusicBrainz::Server::Moderation::MOD_ADD_ARTIST_ANNOTATION;

use ModDefs;
use MusicBrainz::Server::Annotation ':type';
use base 'Moderation';

sub Name { "Add Artist Annotation" }
(__PACKAGE__)->RegisterHandler;

sub PreInsert
{
	my ($self, %opts) = @_;

	my $artistid = $opts{'artistid'} or die;
	my $text = $opts{'text'} || '';
	my $changelog = $opts{'changelog'} || '';

	my %new = (
		Text => $text,
		ChangeLog => $changelog,
	);

	$self->SetArtist($artistid);
	$self->SetNew($self->ConvertHashToNew(\%new));
	$self->SetTable('artist');
	$self->SetColumn('annotation.text');
	$self->SetRowId($artistid);
}

sub DetermineQuality
{
	my $self = shift;

	my $ar = Artist->new($self->{DBH});
	$ar->SetId($self->{rowid});
	if ($ar->LoadFromId())
	{
        return $ar->GetQuality();        
    }
    print STDERR __PACKAGE__ . ": quality not determined\n";
    return &ModDefs::QUALITY_NORMAL;
}

sub PreDisplay
{
	my $this = shift;
	
	# load annotation data
	my $an = MusicBrainz::Server::Annotation->new($this->{DBH});
	$an->SetModeration($this->GetId());
	if ($an->LoadFromId())
	{
		my $log = $an->GetChangeLog;
		$log = "(no change log)"
			unless ($log =~ /\S/);
		$this->{'changelog'} = $log;
		$this->{'annotid'} = $an->GetId;
	}
}

sub ApprovedAction
{
	my $self = shift;

	my $new = $self->ConvertNewToHash($self->GetNew());
	my $changelog = $new->{ChangeLog};
	my $text = $new->{Text};

	require MusicBrainz::Server::Annotation;
	my $an = MusicBrainz::Server::Annotation->new($self->{DBH});

	$an->SetModerator($self->GetModerator());
	$an->SetModeration($self->GetId());
	$an->SetType(ARTIST_ANNOTATION);
	$an->SetArtist($self->GetRowId());
	$an->SetText($text);
	$an->SetChangeLog($changelog);
	$an->Insert();

	return &ModDefs::STATUS_APPLIED;
}

1;
# eof MOD_ADD_ARTIST_ANNOTATION.pm
