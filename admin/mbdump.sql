select * from Artist into outfile '/tmp/mbdump/Artist';
select * from Album into outfile '/tmp/mbdump/Album';
select * from Diskid into outfile '/tmp/mbdump/Diskid';
select * from GUIDJoin into outfile '/tmp/mbdump/GUIDJoin';
select * from GUID into outfile '/tmp/mbdump/GUID';
select * from AlbumJoin into outfile '/tmp/mbdump/AlbumJoin';
select * from Track into outfile '/tmp/mbdump/Track';
select * from TOC into outfile '/tmp/mbdump/TOC';
