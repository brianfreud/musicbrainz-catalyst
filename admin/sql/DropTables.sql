\set ON_ERROR_STOP 1

-- Alphabetical order
DROP TABLE album;
DROP TABLE album_amazon_asin;
DROP TABLE albumjoin;
DROP TABLE albummeta;
DROP TABLE albumwords;
DROP TABLE artist;
DROP TABLE artistalias;
DROP TABLE artistwords;
DROP TABLE clientversion;
DROP TABLE country;
DROP TABLE currentstat;
DROP TABLE discid;
DROP TABLE historicalstat;
DROP TABLE moderation_closed;
DROP TABLE moderation_note_closed;
DROP TABLE moderation_note_open;
DROP TABLE moderation_open;
DROP TABLE moderator;
DROP TABLE moderator_preference;
DROP TABLE moderator_subscribe_artist;
DROP TABLE release;
DROP TABLE stats;
DROP TABLE toc;
DROP TABLE track;
DROP TABLE trackwords;
DROP TABLE trm;
DROP TABLE trmjoin;
DROP TABLE vote_closed;
DROP TABLE vote_open;
DROP TABLE wordlist;

-- Alphabetical order
DROP SEQUENCE album_id_seq;
DROP SEQUENCE albumjoin_id_seq;
DROP SEQUENCE artist_id_seq;
DROP SEQUENCE artist_relation_id_seq;
DROP SEQUENCE artistalias_id_seq;
DROP SEQUENCE clientversion_id_seq;
DROP SEQUENCE country_id_seq;
DROP SEQUENCE discid_id_seq;
DROP SEQUENCE moderation_note_open_id_seq;
DROP SEQUENCE moderation_open_id_seq;
DROP SEQUENCE moderator_id_seq;
DROP SEQUENCE moderator_preference_id_seq;
DROP SEQUENCE moderator_subscribe_artist_id_seq;
DROP SEQUENCE release_id_seq;
DROP SEQUENCE replication_control_id_seq;
DROP SEQUENCE stats_id_seq;
DROP SEQUENCE toc_id_seq;
DROP SEQUENCE track_id_seq;
DROP SEQUENCE trm_id_seq;
DROP SEQUENCE trmjoin_id_seq;
DROP SEQUENCE vote_open_id_seq;
DROP SEQUENCE wordlist_id_seq;

-- vi: set ts=4 sw=4 et :
