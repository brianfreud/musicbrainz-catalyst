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

use 5.008;
no warnings qw( portable );

package MusicBrainz;

require Exporter;
use vars qw(@ISA @EXPORT);
@ISA    = @ISA    = qw( Exporter );
@EXPORT = @EXPORT = qw( );
@EXPORT_OK = @EXPORT_OK = qw( encode_entities );

use strict;
use DBI;
use DBDefs;
use Carp qw( carp );
use Encode qw( decode );
use Text::Unaccent qw( unac_string );

sub new
{
    my $class = shift;
    bless {}, ref($class) || $class;
}  

sub Login
{
   my ($this, $quiet, $dsn) = @_;

   $dsn = DBDefs->DSN if (!defined $dsn);
   $this->{DBH} = DBI->connect($dsn,DBDefs->DB_USER,DBDefs->DB_PASSWD,
                               { RaiseError => 1, PrintError => 0, AutoCommit => 1 });
   return 0 if (!$this->{DBH});

   require Sql;
   my $sql = Sql->new($this->{DBH});
   $sql->AutoCommit(1);
   $sql->Do("SET TIME ZONE 'UTC'");
   $sql->AutoCommit(1);
   $sql->Do("SET CLIENT_ENCODING = 'UNICODE'");

   return 1;
}

sub Logout
{
   my ($this) = @_;

   $this->{DBH}->disconnect() if ($this->{DBH});
}

sub DESTROY
{
    shift()->Logout;
}

sub IsNonNegInteger
{
	my $t = shift;
	defined($t) and $t =~ /\A(\d{1,20})\z/;
}

sub IsSingleLineString
{
	my $t = shift;
	defined($t) or return undef;

	use Encode qw( decode FB_CROAK );
	my $s = eval { decode("utf-8", $t, FB_CROAK) };
	return undef if $@;

	$t =~ /\A([^\x00-\x1F]*)\z/;
}

sub IsGUID
{
	my $t = $_[0];
	defined($t) or return undef;
	length($t) eq 36 or return undef;

	$t =~ /[^0-]/ or return undef;

	$t = lc $t;
	$t =~ /\A(
		[0-9a-f]{8}
		- [0-9a-f]{4}
		- [0-9a-f]{4}
		- [0-9a-f]{4}
		- [0-9a-f]{12}
		)\z/x or return undef;
	$_[0] = $1;
	1;
}

sub TrimInPlace
{
	carp "Uninitialized value passed to TrimInPlace"
		if grep { not defined } @_;
	for (@_)
	{
		$_ = "" if not defined;
		# TODO decode, trim, encode?
		s/\A\s+//;
		s/\s+\z//;
	}
}

sub NormaliseSortText
{
	lc decode('utf-8', unac_string('UTF-8', shift));
}
*NormalizeSortText = \&NormaliseSortText;

# HTML-encoding, but only on the listed "unsafe" characters.  Specifically,
# don't (incorrectly) encode top-bit-set characters as &Atilde; and the like.
sub encode_entities
{
	use HTML::Entities ();
	HTML::Entities::encode_entities($_[0], "<>&\"'");
}

1;
# eof MusicBrainz.pm
