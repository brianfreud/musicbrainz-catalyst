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

package MusicBrainz::Server::News;

use Exporter;
use POSIX;
use TableBase;
{ our @ISA = qw( Exporter TableBase ) }
use strict;
use ModDefs;
use Sql;
use MusicBrainz::Server::Cache;
use MusicBrainz::Server::ReleaseEvent;

sub new
{
	my ($type, $dbh) = @_;

	my $this = { dbh => $dbh };
	return bless $this, $type;
}

sub dbh
{
	my ($self, $new_value) = @_;
	
	if (defined $new_value) { $self->{dbh} = $new_value; }
	return $self->{dbh};
}

sub GetRecentReleases
{
    my ($self, $maxitems, $offset) = @_;

	$maxitems = 10 if (!defined $maxitems);

	my $obj = MusicBrainz::Server::Cache->get("statistics-recent-releases");
	my ($recent, $numitems, $timestamp) = ($obj->[0], $obj->[1], $obj->[2]);
	if (!$recent)
	{
		my $sql = Sql->new($self->{dbh});
		$recent = $sql->SelectListOfHashes("SELECT album.gid AS release_mbid, album.name AS release_name, 
				                                   artist.gid AS artist_mbid, artist.name AS artist_name, 
												   releasedate, isocode AS country, format 
										  FROM release, album, artist, country 
										 WHERE album.id IN (
												SELECT album 
												  FROM release 
												 WHERE releasedate <= now() 
												   AND now() - to_timestamp(releasedate, 'YYYY-MM-DD') < interval '60 days'
											  ORDER BY releasedate DESC, album) 
										   AND release.album = album.id 
										   AND release.country = country.id 
										   AND album.artist = artist.id 
										   AND releasedate <= now() 
									  ORDER BY releasedate DESC, album.id, country, format");
		foreach my $row (@$recent)
		{
			$row->{format} = &MusicBrainz::Server::ReleaseEvent::release_format_name($row->{format});
		}

		$timestamp = time();
		$numitems = $sql->SelectSingleValue("SELECT count(*) 
		                                  FROM release 
										 WHERE releasedate <= now() 
										   AND now() - to_timestamp(releasedate, 'YYYY-MM-DD') < interval '30 days'");
		MusicBrainz::Server::Cache->set("statistics-recent-releases", [$recent, $numitems, $timestamp], 60 * 60);
	}

	splice(@$recent, 0, $offset) if ($offset);
	splice(@$recent, $maxitems) if (scalar(@$recent) > $maxitems);

	return ($recent, $numitems, $timestamp);
}

sub GetUpcomingReleases
{
    my ($self, $maxitems, $offset) = @_;

	$maxitems = 10 if (!defined $maxitems);
	my $obj = MusicBrainz::Server::Cache->get("statistics-upcoming-releases");
	my ($upcoming, $numitems, $timestamp) = ($obj->[0], $obj->[1], $obj->[2]);
	if (!$upcoming)
	{
		my $sql = Sql->new($self->{dbh});
		$upcoming = $sql->SelectListOfHashes("SELECT album.gid AS release_mbid, album.name AS release_name,
                                                    artist.gid AS artist_mbid, artist.name AS artist_name,
												    releasedate, isocode AS country, format 
										  FROM release, album, artist, country 
										 WHERE album.id IN (
												SELECT album 
												  FROM release 
												 WHERE releasedate > now() 
											  ORDER BY releasedate, album) 
										   AND release.album = album.id 
										   AND release.country = country.id 
										   AND album.artist = artist.id 
										   AND releasedate > now() 
									  ORDER BY releasedate, album.id, country, format");
		foreach my $row (@$upcoming)
		{
			$row->{format} = &MusicBrainz::Server::ReleaseEvent::release_format_name($row->{format});
		}
		$timestamp = time();
		$numitems = $sql->SelectSingleValue("SELECT count(*) 
		                                  FROM release 
										 WHERE releasedate > now()");
		MusicBrainz::Server::Cache->set("statistics-upcoming-releases", [$upcoming, $numitems, $timestamp], 60 * 60);
	}
	splice(@$upcoming, 0, $offset) if ($offset);
	splice(@$upcoming, $maxitems) if (scalar(@$upcoming) > $maxitems);

	return ($upcoming, $numitems, $timestamp);
}

sub GetRecentlyDeceased
{
    my ($self, $maxitems, $offset) = @_;
	my %data;

	$maxitems = 10 if (!defined $maxitems);
	my $obj = MusicBrainz::Server::Cache->get("statistics-recently-deceased");
	my ($deceased, $numitems, $timestamp) = ($obj->[0], $obj->[1], $obj->[2]);
	if (!$deceased)
	{
		my $sql = Sql->new($self->{dbh});
		$deceased = $sql->SelectListOfHashes("SELECT gid AS mbid, name, enddate, begindate 
										  FROM artist 
										 WHERE type = 1 
										   AND enddate != '' 
										   AND now() - to_timestamp(enddate, 'YYYY-MM-DD') < interval '12 months'
									  ORDER BY enddate DESC");

		$timestamp = time();
		$numitems = $sql->SelectSingleValue("SELECT count(*) 
		                                  FROM artist 
										 WHERE enddate != '' 
										   AND type = 1
										   AND now() - to_timestamp(enddate, 'YYYY-MM-DD') < interval '12 months'");
		MusicBrainz::Server::Cache->set("statistics-recently-deceased", [$deceased, $numitems, $timestamp], 60 * 60);
	}
	splice(@$deceased, 0, $offset) if ($offset);
	splice(@$deceased, $maxitems) if (scalar(@$deceased) > $maxitems);

	return ($deceased, $numitems, $timestamp);
}

sub GetRecentlyBrokenUp
{
    my ($self, $maxitems, $offset) = @_;
	my %data;

	$maxitems = 10 if (!defined $maxitems);

	my $obj = MusicBrainz::Server::Cache->get("statistics-recently-brokenup");
	my ($brokenup, $numitems, $timestamp) = ($obj->[0], $obj->[1], $obj->[2]);
	if (!$brokenup)
	{
		my $sql = Sql->new($self->{dbh});
		$brokenup = $sql->SelectListOfHashes("SELECT gid AS mbid, name, enddate, begindate 
									  FROM artist 
									 WHERE type = 2 
									   AND enddate != '' 
									   AND enddate <= now()
									   AND now() - to_timestamp(enddate, 'YYYY-MM-DD') < interval '12 months'
					              ORDER BY enddate DESC");

		$timestamp = time();
		$numitems = $sql->SelectSingleValue("SELECT count(*) 
		                                  FROM artist 
										 WHERE enddate != '' 
										   AND enddate <= now() 
										   AND type = 2
										   AND now() - to_timestamp(enddate, 'YYYY-MM-DD') < interval '12 months'");
		MusicBrainz::Server::Cache->set("statistics-recently-brokenup", [$brokenup, $numitems, $timestamp], 60 * 60);
	}
	splice(@$brokenup, 0, $offset) if ($offset);
	splice(@$brokenup, $maxitems) if (scalar(@$brokenup) > $maxitems);

	return ($brokenup, $numitems, $timestamp);
}

1;
# vi: set ts=4 sw=4 :
