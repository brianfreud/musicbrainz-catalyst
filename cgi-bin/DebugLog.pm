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

package DebugLog;

sub open
{
	my $class = shift;
	use IO::File;
	my $fh = IO::File->new(&DBDefs::DEBUG_LOG, &O_WRONLY|&O_APPEND)
		or return undef;
	#use Fcntl qw( :flock );
	#flock($fh, LOCK_EX);
	$fh->autoflush(1);
	bless [$fh], ref($class) || $class;
}

sub close
{
	my $self = shift;
	my $fh = $self->[0];

	CORE::close($fh);
	@$self = ();
}

sub stamp
{
	my ($self, $filename, $line, $sub) = @_;
	my $fh = $self->[0];

	use Time::HiRes qw( gettimeofday );
	my @t = gettimeofday;
	my @c = ((@_ > 1) ? @_ : caller(1));

	use POSIX ();

	printf $fh "%s.%06d [%d] : called from %s (%s line %d)\n",
		POSIX::strftime('%Y-%m-%d %H:%M:%S', gmtime $t[0]),
		$t[1],
		$$,
		$c[3] || "?",
		$c[1] || "?",
		$c[2] || 0,
		;
}

sub print
{
	my ($self, @things) = @_;
	my $fh = $self->[0];
	print $fh @things;
}

sub printf
{
	my ($self, $format, @things) = @_;
	my $fh = $self->[0];
	printf $fh $format, @things;
}

sub dumper
{
	my ($self, $vars, $names) = @_;
	my $fh = $self->[0];
	use Data::Dumper;
	print {$fh} Data::Dumper->Dump($vars, $names);
}

# XXX Don't use this yet, it doesn't work.
sub dump
{
	my ($self, @things) = @_;
	my $fh = $self->[0];
	CORE::open(SAVEERR, ">&STDERR");
	CORE::open(STDERR, ">&" . fileno($fh));
	use Devel::Peek qw( Dump );
	Dump($_) for @things;
	CORE::open(STDERR, ">&SAVEERR");
	close SAVEERR;
}

1;
# eof DebugLog.pm
