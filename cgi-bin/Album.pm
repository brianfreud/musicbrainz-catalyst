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
                                                                               
package Album;
use TableBase;

BEGIN { require 5.6.1 }
use vars qw(@ISA @EXPORT);
@ISA    = (TableBase);
@EXPORT = '';

use strict;
use DBI;
use DBDefs;
use Artist;
use Track;
use Discid;
use TRM;
use SearchEngine;
use ModDefs;

sub new
{
   my ($type, $dbh) = @_;

   my $this = TableBase->new($dbh);
   return bless $this, $type;
}

# Accessor functions to set/get the artist id of this album
sub GetArtist
{
   return $_[0]->{artist};
}

sub SetArtist
{
   $_[0]->{artist} = $_[1];
}

# Insert an album that belongs to this artist. The Artist object should've
# been loaded with a LoadFromXXXX call, or the id of this artist must be
# set before this function is called.
sub Insert
{
    my ($this) = @_;
    my ($album, $id, $sql, $name);

    $this->{new_insert} = 0;
    return undef if (!exists $this->{artist} || $this->{artist} eq '');
    return undef if (!exists $this->{name} || $this->{name} eq '');

    $sql = Sql->new($this->{DBH});
    $name = $sql->Quote($this->{name});
    $id = $sql->Quote($this->CreateNewGlobalId());

    if ($sql->Do(qq/insert into Album (name,artist,gid,modpending)
                values ($name,$this->{artist}, $id, 0)/))
    {
        $album = $sql->GetLastInsertId('Album');
        $this->{new_insert} = 1;
    }

    $this->{id} = $album;

    # Add search engine tokens.
    # TODO This should be in a trigger if we ever get a real DB.

    my $engine = SearchEngine->new($this->{DBH}, { Table => 'Album' } );
    $engine->AddWordRefs($album,$this->{name});

    return $album;
}

# Remove an album from the database. Set the id via the accessor function.
sub Remove
{
    my ($this) = @_;
    my ($sql, $sql2, $album, @row, @row2);

    $album = $this->GetId();
    return if (!defined $album);
  
    $sql = Sql->new($this->{DBH});
    print STDERR "DELETE: Removed Discid where album was " . $album . "\n";
    $sql->Do("delete from Discid where album = $album");
    print STDERR "DELETE: Removed TOC where album was " . $album . "\n";
    $sql->Do("delete from TOC where album = $album");

    if ($sql->Select(qq|select AlbumJoin.track from AlbumJoin 
                         where AlbumJoin.album = $album|))
    {
         my $tr = Track->new($this->{DBH});
         while(@row = $sql->NextRow)
         {
             print STDERR "DELETE: Removed albumjoin " . $row[0] . "\n";
             $sql->Do("delete from AlbumJoin where track=$row[0]");
             $tr->SetId($row[0]);
             $tr->Remove();
         }
         $sql->Finish;
    }

    # Remove references from album words table
    my $engine = SearchEngine->new($this->{DBH},  { Table => 'Album' } );
    $engine->RemoveObjectRefs($this->GetId());

    print STDERR "DELETE: Removed Album " . $album . "\n";
    $sql->Do("delete from Album where id = $album");

    return 1;
}

# Given an album, query the number of tracks present in this album
# Returns the number of tracks or undef on error
sub GetTrackCount
{
   my ($this) = @_;
   my ($sql);

   return undef if (!exists $this->{id});
   if (!exists $this->{trackcount} || !defined $this->{trackcount})
   {
        $sql = Sql->new($this->{DBH});
        ($this->{trackcount}) = $sql->GetSingleRow("AlbumJoin", 
                                  ["count(*)"], ["album", $this->{id}]);
   }

   return $this->{trackcount};
}

# Returns the number of TRM ids for this album or undef on error
sub GetTRMCount
{
   my ($this) = @_;
   my ($sql);

   return undef if (!exists $this->{id});
   if (!exists $this->{trmcount} || !defined $this->{trmcount})
   {
        $sql = Sql->new($this->{DBH});
        ($this->{trmcount}) = $sql->GetSingleRow("AlbumJoin, TRMJoin", 
                                  ["count(*)"], 
                                  ["album", $this->{id}, 
                                   "AlbumJoin.track", "TRMJoin.track"]);
   }

   return $this->{trmcount};
}

# This function takes a track id and returns an array of album ids
# on which this track appears. The array is empty on error.
sub GetAlbumIdsFromTrackId
{
   my ($this, $trackid) = @_;
   my (@albums, $sql, @row);

   $sql = Sql->new($this->{DBH});
   if ($sql->Select(qq\select distinct album from AlbumJoin where 
                       track=$trackid\))
   {
        while(@row = $sql->NextRow)
        {
            push @albums, $row[0];
        }
        $sql->Finish;
   }

   return @albums;
}

# This function takes a track id and returns an array of album ids
# on which this track appears. The array is empty on error.
sub GetAlbumIdsFromAlbumJoinId
{
   my ($this, $joinid) = @_;
   my (@albums, $sql, @row);

   $sql = Sql->new($this->{DBH});
   if ($sql->Select(qq\select distinct album from AlbumJoin where 
                       id=$joinid\))
   {
        while(@row = $sql->NextRow)
        {
            push @albums, $row[0];
        }
        $sql->Finish;
   }

   return @albums;
}

# Load an album record. Set the album id via the SetId accessor
# returns 1 on success, undef otherwise. Access the artist info via the
# accessor functions.
sub LoadFromId
{
   my ($this) = @_;
   my ($sth, $sql, @row);

   $sql = Sql->new($this->{DBH});
   @row = $sql->GetSingleRow("Album", [qw(id name GID modpending artist)],
                             ["id", $this->{id}]);
   if (defined $row[0])
   {
        $this->{id} = $row[0];
        $this->{name} = $row[1];
        $this->{mbid} = $row[2];
        $this->{modpending} = $row[3];
        $this->{artist} = $row[4]; 
        return 1;
   }
   return undef;
}

# Load an album record. Set the album name via the SetName accessor, and 
# set the artist via the SetArtist function.
# returns 1 on success, undef otherwise. Access the Album info via the
# accessor functions.
sub LoadFromName
{
   my ($this) = @_;
   my ($sth, $sql, @row);

   return undef if (!exists $this->{name} || $this->{name} eq '');
   return undef if (!exists $this->{artist} || $this->{artist} eq '');

   $sql = Sql->new($this->{DBH});
   @row = $sql->GetSingleRowLike("Album", [qw(id name GID modpending artist)],
                                 ["name", $sql->Quote($this->{name}),
                                  "artist", $this->{artist}]);
   if (defined $row[0])
   {
        $this->{id} = $row[0];
        $this->{name} = $row[1];
        $this->{mbid} = $row[2];
        $this->{modpending} = $row[3];
        $this->{artist} = $row[4]; 
        return 1;
   }
   return undef;
}

# Load tracks for current album. Returns an array of Track references
# The array is empty if there are no tracks or on error
sub LoadTracks
{
   my ($this, $full) = @_;
   my (@info, $query, $query2, $sql, $sql2, @row, @row2, $track, $trm);

   $sql = Sql->new($this->{DBH});
   $trm = TRM->new($this->{DBH});
   $query = qq|select Track.id, Track.name, Track.artist,
                      AlbumJoin.sequence, Track.length,
                      Track.modpending, AlbumJoin.modpending, Track.GID 
               from   Track, AlbumJoin 
               where  AlbumJoin.track = Track.id
                      and AlbumJoin.album = $this->{id} 
             order by AlbumJoin.sequence|;

   if ($sql->Select($query))
   {
       for(;@row = $sql->NextRow();)
       {
           $track = Track->new($this->{DBH});
           $track->SetId($row[0]);
           $track->SetName($row[1]);
           $track->SetArtist($row[2]);
           $track->SetSequence($row[3]);
           $track->SetLength($row[4]);
           $track->SetModPending($row[5]);
           $track->SetAlbumJoinModPending($row[6]);
           $track->SetMBId($row[7]);

           if (defined $full && $full)
           {
               my $ret = $trm->LoadFull($row[0]);
               if (defined $ret)
               {
                   $track->{"_trms"} = $ret;
               }
           }

           push @info, $track;
       }
       $sql->Finish;
   }

   return @info;
}

# Load tracks for the given artist. Returns a reference to an array of references to
# album objects, or undef if no albums or error
sub LoadFull
{
   my ($this, $artist) = @_;
   my (@info, $query, $sql, @row, $album, $di, $ret);

   $sql = Sql->new($this->{DBH});
   $di = Discid->new($this->{DBH});
   $query = qq|select id, name, artist, gid 
                 from Album 
                where artist = $artist 
                order by name|;
   if ($sql->Select($query) && $sql->Rows)
   {
       for(;@row = $sql->NextRow();)
       {
           $album = Album->new($this->{DBH});
           $album->SetId($row[0]);
           $album->SetName($row[1]);
           $album->SetArtist($row[2]);
           $album->SetMBId($row[3]);
           my @tracks = $album->LoadTracks(1);
           if (scalar(@tracks) > 0)
           {
               $album->{"_tracks"} = \@tracks;
           }

           $ret = $di->LoadFull($row[0]);
           if (defined $ret)
           {
               $album->{"_discids"} = $ret;
           }
           push @info, $album;
       }
       $sql->Finish;
   
       return \@info;
   }

   return undef;
}

sub LoadTracksFromMultipleArtistAlbum
{
   my ($this) = @_;
   my (@info, $query, $sql, @row, $track);

   $sql = Sql->new($this->{DBH});
   $query = qq/select Track.id, Track.name, Track.artist, AlbumJoin.sequence, 
                      Track.length, Track.modpending, AlbumJoin.modpending, 
                      Artist.name, Track.gid 
                 from Track, AlbumJoin, Artist 
                where AlbumJoin.track = Track.id and 
                      AlbumJoin.album = $this->{id} and 
                      Track.Artist = Artist.id
             order by AlbumJoin.sequence/;
   if ($sql->Select($query))
   {
       for(;@row = $sql->NextRow();)
       {
           $track = Track->new($this->{DBH});
           $track->SetId($row[0]);
           $track->SetName($row[1]);
           $track->SetArtist($row[2]);
           $track->SetSequence($row[3]);
           $track->SetLength($row[4]);
           $track->SetModPending($row[5]);
           $track->SetAlbumJoinModPending($row[6]);
           $track->SetArtistName($row[7]);
           $track->SetMBId($row[8]);
           push @info, $track;
       }
       $sql->Finish;
   }

   return @info;
}

# Load trmid counts for current album. Returns an array of Track references
# The array is empty if there are no tracks or on error
sub LoadTRMCount
{
   my ($this) = @_;
   my ($query, $sql, @row, %trmcount);

   $sql = Sql->new($this->{DBH});
   $query = qq|select AlbumJoin.track, count(TRMJoin.track) as num_trm 
                 from AlbumJoin, TRMJoin 
                where AlbumJoin.album = $this->{id} and 
                      AlbumJoin.track = TRMJoin.track 
             group by AlbumJoin.track, AlbumJoin.sequence, albumjoin.id 
             order by AlbumJoin.sequence, AlbumJoin.id|;

   if ($sql->Select($query))
   {
       for(;@row = $sql->NextRow();)
       {
           $trmcount{$row[0]} = $row[1];
       }
       $sql->Finish;
   }

   return \%trmcount;
}

# Given a list of albums, this function will merge the list of albums into
# the current album. All Discids and TRM Ids are preserved in the process
sub MergeAlbums
{
   my ($this, $intoMAC, @list) = @_;
   my ($al, $ar, $tr, @tracks, %merged, $id, $sql);
   
   return undef if (scalar(@list) < 1);

   @tracks = $this->LoadTracks();
   return undef if (scalar(@tracks) == 0);

   # Create a hash that contains the original album
   foreach $tr (@tracks)
   {
      $merged{$tr->GetSequence()} = $tr;
   }

   $sql = Sql->new($this->{DBH});
   # If we're merging into a MAC, then set this album to a MAC album
   if ($intoMAC)
   {
      $sql->Do("update Album set artist = " . ModDefs::VARTIST_ID . 
               " where id = " . $this->GetId());
   }

   $al = Album->new($this->{DBH});
   foreach $id (@list)
   {
       $al->SetId($id);
       next if (!defined $al->LoadFromId());

       @tracks = $al->LoadTracks();
       foreach $tr (@tracks)
       {
           if (exists $merged{$tr->GetSequence()})
           {
                # We already have that track. Move any existing TRMs
                # to the existing track
                $sql->Do("update TRMJoin set track = " .
                         $merged{$tr->GetSequence()}->GetId() . 
                         " where track = " . $tr->GetId());
           }
           else
           {
                # We don't already have that track
                $sql->Do("update AlbumJoin set Album = " . 
                         $this->GetId() . " where track = " . $tr->GetId());
                $merged{$tr->GetSequence()} = $tr;
           }

           if (!$intoMAC)
           {
                # Move that the track to the target album's artist
                $sql->Do("update Track set artist = " . $this->GetArtist() .
                         " where id = " . $tr->GetId());
           }                
       }

       # Also merge the Discids
       $sql->Do("update Discid set Album = " . $this->GetId() . 
                " where Album = $id");
       $sql->Do("update TOC set Album = " . $this->GetId() . 
                " where Album = $id");

       # Then, finally remove what is left of the old album
       $al->Remove();
   }

   return 1;
}


# Pull back a section of various artist albums for the browse various display.
# Given an index character ($ind), a page offset ($offset) and a page length
# ($max_items) it will return an array of references to an array
# of albumid, sortname, modpending. The array is empty on error.
sub GetVariousDisplayList
{
   my ($this, $ind, $offset, $max_items) = @_;
   my ($query, $num_albums, @info, @row, $sql, $ind_len); 

   $ind_len = length($ind);
   return undef if ($ind_len <= 0);

   $sql = Sql->new($this->{DBH});
   ($num_albums) =  $sql->GetSingleRowLike("Album", ["count(*)"], 
                                        ["substring(name from 1 for $ind_len)", 
                                         $sql->Quote($ind),
                                         "Album.artist", ModDefs::VARTIST_ID]);
   return undef if (!defined $num_albums);
   
   if ($ind =~ m/_/)
   {
      $ind =~ s/_/[^A-Za-z]/g;
      $ind = "^$ind";
      $query = qq/select id, name, modpending 
                  from   Album 
                  where  name ~ '$ind' and
                         Album.artist = / . ModDefs::VARTIST_ID . qq/
                  order  by name 
                  limit  $max_items offset $offset/;
      print STDERR "$query\n";
   }
   else
   {
      $query = qq/select id, name, modpending from Album 
                   where substring(name from 1 for $ind_len) ilike '$ind' and
                         Album.artist = / . ModDefs::VARTIST_ID . qq/
                order by name 
                   limit $max_items offset $offset/;
   }
   if ($sql->Select($query))
   {
       for(;@row = $sql->NextRow;)
       {
           push @info, [$row[0], $row[1], $row[2]];
       }
       $sql->Finish;   
   }

   return ($num_albums, @info);
}
