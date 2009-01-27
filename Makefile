# This Makefile is for the musicbrainz extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.48 (Revision: 64800) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#
#   MakeMaker Parameters:

#     ABSTRACT => q[Catalyst based application]
#     AUTHOR => q[Catalyst developer]
#     DIR => []
#     DISTNAME => q[musicbrainz]
#     EXE_FILES => [q[script/musicbrainz_cgi.pl], q[script/musicbrainz_create.pl], q[script/musicbrainz_fastcgi.pl], q[script/musicbrainz_server.pl], q[script/musicbrainz_test.pl]]
#     NAME => q[musicbrainz]
#     NO_META => q[1]
#     PL_FILES => {  }
#     PREREQ_PM => { YAML=>q[0], Catalyst::Plugin::ConfigLoader=>q[0], Email::Date::Format=>q[0], Catalyst::Plugin::Session::Store::FastMmap=>q[0], Catalyst::Plugin::Session::State::Cookie=>q[0], Cache::Memcached=>q[0], Text::Unaccent=>q[0], MIME::Lite=>q[0], DBI=>q[0], Catalyst::View::TT=>q[0], parent=>q[0], Catalyst::Component::ACCEPT_CONTEXT=>q[0], XML::Feed=>q[0], DBD::Pg=>q[0], ExtUtils::MakeMaker=>q[6.48], String::ShellQuote=>q[0], OSSP::uuid=>q[0], Date::Calc=>q[0], Catalyst::Plugin::Form::Processor=>q[0], Email::Valid=>q[0], Text::WikiFormat=>q[0], Digest::MD5=>q[0], Algorithm::Diff=>q[0], Moose=>q[0], Catalyst::View::Email=>q[0], Catalyst::Plugin::Static::Simple=>q[0], Digest::SHA1=>q[0], Catalyst::Plugin::StackTrace=>q[0], Catalyst::Action::RenderView=>q[0], Data::Page=>q[0], Catalyst::Plugin::Authentication=>q[0], String::Similarity=>q[0], Catalyst::Runtime=>q[5.71000], JSON=>q[0], Devel::Peek=>q[0], Form::Processor=>q[0] }
#     VERSION => q[0.01]
#     clean => { FILES=>q[META.yml] }
#     dist => { PREOP=>q[$(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"] }
#     test => { TESTS=>q[t/01app.t t/02pod.t t/03podcoverage.t t/controller_Main.t t/controller_User.t t/replace_ar_attribs.t t/taglookup_lucene_query.t t/view_Default.t t/view_Main.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl/5.10/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -O2 -g -L/usr/local/lib
LDFLAGS =  -L/usr/local/lib
LIBC = /lib/libc-2.8.90.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.24-16-server
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.10.0
SITEARCHEXP = /usr/local/lib/perl/5.10.0
SO = so
VENDORARCHEXP = /usr/lib/perl5
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = musicbrainz
NAME_SYM = musicbrainz
VERSION = 0.01
VERSION_MACRO = VERSION
VERSION_SYM = 0_01
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.01
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = $(SITEPREFIX)
PERLPREFIX = /usr
SITEPREFIX = /usr/local
VENDORPREFIX = /usr
INSTALLPRIVLIB = /usr/share/perl/5.10
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /usr/local/share/perl/5.10.0
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = /usr/share/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /usr/lib/perl/5.10
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /usr/local/lib/perl/5.10.0
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = /usr/lib/perl5
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /usr/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /usr/local/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = /usr/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /usr/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /usr/local/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = /usr/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /usr/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /usr/local/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = /usr/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /usr/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /usr/local/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = /usr/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /usr/lib/perl/5.10
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl/5.10/CORE
PERL = /usr/bin/perl "-Iinc"
FULLPERL = /usr/bin/perl "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/local/share/perl/5.10.0/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.48
MM_REVISION = 64800

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = musicbrainz
BASEEXT = musicbrainz
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = 
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/musicbrainz_cgi.pl \
	script/musicbrainz_create.pl \
	script/musicbrainz_fastcgi.pl \
	script/musicbrainz_server.pl \
	script/musicbrainz_test.pl
MAN3PODS = lib/LocaleSaver.pm \
	lib/MusicBrainz/Server.pm \
	lib/MusicBrainz/Server/Adapter.pm \
	lib/MusicBrainz/Server/Alias.pm \
	lib/MusicBrainz/Server/Artist.pm \
	lib/MusicBrainz/Server/Cache.pm \
	lib/MusicBrainz/Server/Controller.pm \
	lib/MusicBrainz/Server/Controller/AddRelease.pm \
	lib/MusicBrainz/Server/Controller/Artist.pm \
	lib/MusicBrainz/Server/Controller/Label.pm \
	lib/MusicBrainz/Server/Controller/Moderation.pm \
	lib/MusicBrainz/Server/Controller/Release.pm \
	lib/MusicBrainz/Server/Controller/Root.pm \
	lib/MusicBrainz/Server/Controller/Search.pm \
	lib/MusicBrainz/Server/Controller/Statistics.pm \
	lib/MusicBrainz/Server/Controller/Tags.pm \
	lib/MusicBrainz/Server/Controller/Track.pm \
	lib/MusicBrainz/Server/Controller/Url.pm \
	lib/MusicBrainz/Server/Controller/User.pm \
	lib/MusicBrainz/Server/Form.pm \
	lib/MusicBrainz/Server/Form/Artist/Base.pm \
	lib/MusicBrainz/Server/Form/DataQuality.pm \
	lib/MusicBrainz/Server/Form/Field/Compound.pm \
	lib/MusicBrainz/Server/Form/Field/Date.pm \
	lib/MusicBrainz/Server/Form/Field/Track.pm \
	lib/MusicBrainz/Server/Form/Label/Base.pm \
	lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	lib/MusicBrainz/Server/Form/User/EditProfile.pm \
	lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	lib/MusicBrainz/Server/Form/User/Login.pm \
	lib/MusicBrainz/Server/Form/User/Preferences.pm \
	lib/MusicBrainz/Server/Form/User/Register.pm \
	lib/MusicBrainz/Server/Label.pm \
	lib/MusicBrainz/Server/Model/Artist.pm \
	lib/MusicBrainz/Server/Model/Relation.pm \
	lib/MusicBrainz/Server/Model/Release.pm \
	lib/MusicBrainz/Server/Model/Tag.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	lib/MusicBrainz/Server/RateLimit.pm \
	lib/TableBase.pm \
	lib/UserPreference.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/DBDefs.pm.default \
	lib/DebugLog.pm \
	lib/FreeDB.pm \
	lib/Insert.pm \
	lib/LocaleSaver.pm \
	lib/MM.pm \
	lib/MM_2_0.pm \
	lib/MM_2_1.pm \
	lib/ModDefs.pm \
	lib/Moderation.pm \
	lib/MusicBrainz.pm \
	lib/MusicBrainz/Server.pm \
	lib/MusicBrainz/Server/Action/Form.pm \
	lib/MusicBrainz/Server/Adapter.pm \
	lib/MusicBrainz/Server/Alias.pm \
	lib/MusicBrainz/Server/Annotation.pm \
	lib/MusicBrainz/Server/Artist.pm \
	lib/MusicBrainz/Server/Attribute.pm \
	lib/MusicBrainz/Server/Authentication/Store.pm \
	lib/MusicBrainz/Server/AutomodElection.pm \
	lib/MusicBrainz/Server/CDTOC.pm \
	lib/MusicBrainz/Server/Cache.pm \
	lib/MusicBrainz/Server/Controller.pm \
	lib/MusicBrainz/Server/Controller/AddRelease.pm \
	lib/MusicBrainz/Server/Controller/Annotation.pm \
	lib/MusicBrainz/Server/Controller/Artist.pm \
	lib/MusicBrainz/Server/Controller/Browse.pm \
	lib/MusicBrainz/Server/Controller/CdToc.pm \
	lib/MusicBrainz/Server/Controller/Doc.pm \
	lib/MusicBrainz/Server/Controller/FreeDB.pm \
	lib/MusicBrainz/Server/Controller/Label.pm \
	lib/MusicBrainz/Server/Controller/Moderation.pm \
	lib/MusicBrainz/Server/Controller/Relate.pm \
	lib/MusicBrainz/Server/Controller/Release.pm \
	lib/MusicBrainz/Server/Controller/Review.pm \
	lib/MusicBrainz/Server/Controller/Root.pm \
	lib/MusicBrainz/Server/Controller/Search.pm \
	lib/MusicBrainz/Server/Controller/Statistics.pm \
	lib/MusicBrainz/Server/Controller/Tags.pm \
	lib/MusicBrainz/Server/Controller/Track.pm \
	lib/MusicBrainz/Server/Controller/Url.pm \
	lib/MusicBrainz/Server/Controller/User.pm \
	lib/MusicBrainz/Server/Country.pm \
	lib/MusicBrainz/Server/CoverArt.pm \
	lib/MusicBrainz/Server/Database.pm \
	lib/MusicBrainz/Server/DateTime.pm \
	lib/MusicBrainz/Server/DeferredUpdate.pm \
	lib/MusicBrainz/Server/Editor.pm \
	lib/MusicBrainz/Server/Filters.pm \
	lib/MusicBrainz/Server/Form.pm \
	lib/MusicBrainz/Server/Form/AddRelease/TrackCount.pm \
	lib/MusicBrainz/Server/Form/AddRelease/Tracks.pm \
	lib/MusicBrainz/Server/Form/Alias.pm \
	lib/MusicBrainz/Server/Form/Alias/Add.pm \
	lib/MusicBrainz/Server/Form/Annotation/Edit.pm \
	lib/MusicBrainz/Server/Form/Artist/AddAlias.pm \
	lib/MusicBrainz/Server/Form/Artist/AddNonAlbum.pm \
	lib/MusicBrainz/Server/Form/Artist/Base.pm \
	lib/MusicBrainz/Server/Form/Artist/Create.pm \
	lib/MusicBrainz/Server/Form/Artist/DataQuality.pm \
	lib/MusicBrainz/Server/Form/Artist/Edit.pm \
	lib/MusicBrainz/Server/Form/Artist/EditAlias.pm \
	lib/MusicBrainz/Server/Form/Artist/Merge.pm \
	lib/MusicBrainz/Server/Form/Artist/RemoveAlias.pm \
	lib/MusicBrainz/Server/Form/DataQuality.pm \
	lib/MusicBrainz/Server/Form/Field/Compound.pm \
	lib/MusicBrainz/Server/Form/Field/Date.pm \
	lib/MusicBrainz/Server/Form/Field/Email.pm \
	lib/MusicBrainz/Server/Form/Field/LabelCode.pm \
	lib/MusicBrainz/Server/Form/Field/ReleaseEvent.pm \
	lib/MusicBrainz/Server/Form/Field/Time.pm \
	lib/MusicBrainz/Server/Form/Field/Track.pm \
	lib/MusicBrainz/Server/Form/Field/TrackNumber.pm \
	lib/MusicBrainz/Server/Form/Field/URL.pm \
	lib/MusicBrainz/Server/Form/Label/AddAlias.pm \
	lib/MusicBrainz/Server/Form/Label/Base.pm \
	lib/MusicBrainz/Server/Form/Label/Create.pm \
	lib/MusicBrainz/Server/Form/Label/Edit.pm \
	lib/MusicBrainz/Server/Form/Label/EditAlias.pm \
	lib/MusicBrainz/Server/Form/Label/Merge.pm \
	lib/MusicBrainz/Server/Form/Label/RemoveAlias.pm \
	lib/MusicBrainz/Server/Form/Moderation/AddNote.pm \
	lib/MusicBrainz/Server/Form/Relate/AddCCLicense.pm \
	lib/MusicBrainz/Server/Form/Relate/Remove.pm \
	lib/MusicBrainz/Server/Form/Relate/Url.pm \
	lib/MusicBrainz/Server/Form/Release/ConvertToSingleArtist.pm \
	lib/MusicBrainz/Server/Form/Release/DataQuality.pm \
	lib/MusicBrainz/Server/Form/Release/EditAttributes.pm \
	lib/MusicBrainz/Server/Form/Release/EditTitle.pm \
	lib/MusicBrainz/Server/Form/Release/Move.pm \
	lib/MusicBrainz/Server/Form/Release/Remove.pm \
	lib/MusicBrainz/Server/Form/Search/External.pm \
	lib/MusicBrainz/Server/Form/Search/Query.pm \
	lib/MusicBrainz/Server/Form/Search/Simple.pm \
	lib/MusicBrainz/Server/Form/Tag/Tags.pm \
	lib/MusicBrainz/Server/Form/Track/Base.pm \
	lib/MusicBrainz/Server/Form/Track/ChangeArtist.pm \
	lib/MusicBrainz/Server/Form/Track/Edit.pm \
	lib/MusicBrainz/Server/Form/Track/Remove.pm \
	lib/MusicBrainz/Server/Form/Url/Edit.pm \
	lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	lib/MusicBrainz/Server/Form/User/Contact.pm \
	lib/MusicBrainz/Server/Form/User/EditProfile.pm \
	lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	lib/MusicBrainz/Server/Form/User/Login.pm \
	lib/MusicBrainz/Server/Form/User/Preferences.pm \
	lib/MusicBrainz/Server/Form/User/Register.pm \
	lib/MusicBrainz/Server/Handlers.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Artist.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Auth.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Common.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Label.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Release.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Tag.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Track.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/User.pm \
	lib/MusicBrainz/Server/Handlers/WS/Private/Lookup.pm \
	lib/MusicBrainz/Server/Label.pm \
	lib/MusicBrainz/Server/Language.pm \
	lib/MusicBrainz/Server/Link.pm \
	lib/MusicBrainz/Server/LinkAttr.pm \
	lib/MusicBrainz/Server/LinkEntity.pm \
	lib/MusicBrainz/Server/LinkType.pm \
	lib/MusicBrainz/Server/LogFile.pm \
	lib/MusicBrainz/Server/LuceneSearch.pm \
	lib/MusicBrainz/Server/Markup.pm \
	lib/MusicBrainz/Server/Mason.pm \
	lib/MusicBrainz/Server/ModBot.pm \
	lib/MusicBrainz/Server/Model.pm \
	lib/MusicBrainz/Server/Model/Alias.pm \
	lib/MusicBrainz/Server/Model/Annotation.pm \
	lib/MusicBrainz/Server/Model/Artist.pm \
	lib/MusicBrainz/Server/Model/CdToc.pm \
	lib/MusicBrainz/Server/Model/Documentation.pm \
	lib/MusicBrainz/Server/Model/Feeds.pm \
	lib/MusicBrainz/Server/Model/FreeDB.pm \
	lib/MusicBrainz/Server/Model/Label.pm \
	lib/MusicBrainz/Server/Model/Moderation.pm \
	lib/MusicBrainz/Server/Model/Relation.pm \
	lib/MusicBrainz/Server/Model/Release.pm \
	lib/MusicBrainz/Server/Model/Subscription.pm \
	lib/MusicBrainz/Server/Model/Tag.pm \
	lib/MusicBrainz/Server/Model/Track.pm \
	lib/MusicBrainz/Server/Model/Url.pm \
	lib/MusicBrainz/Server/Model/User.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTISTALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_DISCID.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABELALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_TYPE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_PUIDS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_KV.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_ARTIST_QUALITY.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_RELEASE_QUALITY.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_TRACK_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_WIKIDOC.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTNAME.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTSORTNAME.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABEL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABELALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_TYPE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS_OLD.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_LANGUAGE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_NAME.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNAME.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNUM.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKTIME.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_URL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MAC_TO_SAC.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_LABEL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE_MAC.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_RELEASE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTISTALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABEL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABELALIAS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_TYPE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_PUID.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASES.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_TRACK.pm \
	lib/MusicBrainz/Server/Moderation/MOD_SAC_TO_MAC.pm \
	lib/MusicBrainz/Server/Moderation/MOD_SET_RELEASE_DURATIONS.pm \
	lib/MusicBrainz/Server/ModerationNote.pm \
	lib/MusicBrainz/Server/PUID.pm \
	lib/MusicBrainz/Server/PagedReport.pm \
	lib/MusicBrainz/Server/RateLimit.pm \
	lib/MusicBrainz/Server/Release.pm \
	lib/MusicBrainz/Server/ReleaseCDTOC.pm \
	lib/MusicBrainz/Server/ReleaseEvent.pm \
	lib/MusicBrainz/Server/Replication.pm \
	lib/MusicBrainz/Server/ReportScript.pm \
	lib/MusicBrainz/Server/Script.pm \
	lib/MusicBrainz/Server/Statistic.pm \
	lib/MusicBrainz/Server/TRMGateway.pm \
	lib/MusicBrainz/Server/TRMGatewayHandler.pm \
	lib/MusicBrainz/Server/Tag.pm \
	lib/MusicBrainz/Server/Track.pm \
	lib/MusicBrainz/Server/URL.pm \
	lib/MusicBrainz/Server/Validation.pm \
	lib/MusicBrainz/Server/View/Default.pm \
	lib/MusicBrainz/Server/View/Email/Template.pm \
	lib/MusicBrainz/Server/Vote.pm \
	lib/MusicBrainz/Server/WikiTransclusion.pm \
	lib/MusicBrainz/Server/dbmirror.pm \
	lib/Parser.pm \
	lib/QuerySupport.pm \
	lib/RDF2.pm \
	lib/SearchEngine.pm \
	lib/Sql.pm \
	lib/Style.pm \
	lib/TableBase.pm \
	lib/TaggerSupport.pm \
	lib/UserPreference.pm \
	lib/UserSubscription.pm \
	lib/mq.pl \
	lib/mq_2_1.pl \
	lib/rdf.pl \
	lib/rdf_2_1.pl

PM_TO_BLIB = lib/MusicBrainz/Server/Database.pm \
	blib/lib/MusicBrainz/Server/Database.pm \
	lib/MusicBrainz/Server/Model/Artist.pm \
	blib/lib/MusicBrainz/Server/Model/Artist.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Track.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Track.pm \
	lib/MusicBrainz/Server/Model/User.pm \
	blib/lib/MusicBrainz/Server/Model/User.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_NAME.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_NAME.pm \
	lib/MusicBrainz/Server/Model/CdToc.pm \
	blib/lib/MusicBrainz/Server/Model/CdToc.pm \
	lib/MusicBrainz/Server/ReleaseCDTOC.pm \
	blib/lib/MusicBrainz/Server/ReleaseCDTOC.pm \
	lib/MusicBrainz/Server/Annotation.pm \
	blib/lib/MusicBrainz/Server/Annotation.pm \
	lib/MusicBrainz/Server/Form/Release/ConvertToSingleArtist.pm \
	blib/lib/MusicBrainz/Server/Form/Release/ConvertToSingleArtist.pm \
	lib/MusicBrainz/Server/Form/Release/DataQuality.pm \
	blib/lib/MusicBrainz/Server/Form/Release/DataQuality.pm \
	lib/MusicBrainz/Server/PUID.pm \
	blib/lib/MusicBrainz/Server/PUID.pm \
	lib/TaggerSupport.pm \
	blib/lib/TaggerSupport.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL.pm \
	lib/MusicBrainz/Server/Moderation/MOD_SAC_TO_MAC.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_SAC_TO_MAC.pm \
	lib/MusicBrainz/Server/Form/Field/Email.pm \
	blib/lib/MusicBrainz/Server/Form/Field/Email.pm \
	lib/MusicBrainz/Server/Model/Alias.pm \
	blib/lib/MusicBrainz/Server/Model/Alias.pm \
	lib/MusicBrainz/Server/Markup.pm \
	blib/lib/MusicBrainz/Server/Markup.pm \
	lib/MusicBrainz/Server/URL.pm \
	blib/lib/MusicBrainz/Server/URL.pm \
	lib/MusicBrainz/Server/Model/Feeds.pm \
	blib/lib/MusicBrainz/Server/Model/Feeds.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST.pm \
	lib/TableBase.pm \
	blib/lib/TableBase.pm \
	lib/MusicBrainz/Server/Model/Documentation.pm \
	blib/lib/MusicBrainz/Server/Model/Documentation.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABEL.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABEL.pm \
	lib/Sql.pm \
	blib/lib/Sql.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_ARTIST.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_ARTIST.pm \
	lib/MusicBrainz/Server/Controller/Review.pm \
	blib/lib/MusicBrainz/Server/Controller/Review.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNUM.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNUM.pm \
	lib/MusicBrainz/Server/Model/Tag.pm \
	blib/lib/MusicBrainz/Server/Model/Tag.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_TYPE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_TYPE.pm \
	lib/MusicBrainz/Server/LogFile.pm \
	blib/lib/MusicBrainz/Server/LogFile.pm \
	lib/MusicBrainz/Server/ModerationNote.pm \
	blib/lib/MusicBrainz/Server/ModerationNote.pm \
	lib/MusicBrainz/Server/Form/Track/ChangeArtist.pm \
	blib/lib/MusicBrainz/Server/Form/Track/ChangeArtist.pm \
	lib/MusicBrainz/Server/Link.pm \
	blib/lib/MusicBrainz/Server/Link.pm \
	lib/MusicBrainz/Server/Controller/FreeDB.pm \
	blib/lib/MusicBrainz/Server/Controller/FreeDB.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	lib/MusicBrainz/Server/Form/User/Preferences.pm \
	blib/lib/MusicBrainz/Server/Form/User/Preferences.pm \
	lib/MusicBrainz/Server/Cache.pm \
	blib/lib/MusicBrainz/Server/Cache.pm \
	lib/MM.pm \
	blib/lib/MM.pm \
	lib/MusicBrainz/Server/CDTOC.pm \
	blib/lib/MusicBrainz/Server/CDTOC.pm \
	lib/MusicBrainz/Server/Controller/AddRelease.pm \
	blib/lib/MusicBrainz/Server/Controller/AddRelease.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_TYPE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_TYPE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_EVENTS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_URL.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_URL.pm \
	lib/rdf_2_1.pl \
	blib/lib/rdf_2_1.pl \
	lib/MusicBrainz/Server/Form/Moderation/AddNote.pm \
	blib/lib/MusicBrainz/Server/Form/Moderation/AddNote.pm \
	lib/MusicBrainz/Server/Form/Tag/Tags.pm \
	blib/lib/MusicBrainz/Server/Form/Tag/Tags.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_WIKIDOC.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_WIKIDOC.pm \
	lib/MusicBrainz/Server/Controller/Tags.pm \
	blib/lib/MusicBrainz/Server/Controller/Tags.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_RELEASE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MOVE_RELEASE.pm \
	lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	blib/lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	lib/MusicBrainz/Server/Validation.pm \
	blib/lib/MusicBrainz/Server/Validation.pm \
	lib/MusicBrainz/Server/ReportScript.pm \
	blib/lib/MusicBrainz/Server/ReportScript.pm \
	lib/MusicBrainz/Server/Controller/Release.pm \
	blib/lib/MusicBrainz/Server/Controller/Release.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_ARTIST_QUALITY.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_ARTIST_QUALITY.pm \
	lib/MusicBrainz/Server/Form/Label/AddAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Label/AddAlias.pm \
	lib/MusicBrainz/Server/Language.pm \
	blib/lib/MusicBrainz/Server/Language.pm \
	lib/MusicBrainz/Server/CoverArt.pm \
	blib/lib/MusicBrainz/Server/CoverArt.pm \
	lib/MusicBrainz/Server/Form/Label/Edit.pm \
	blib/lib/MusicBrainz/Server/Form/Label/Edit.pm \
	lib/MusicBrainz.pm \
	blib/lib/MusicBrainz.pm \
	lib/MusicBrainz/Server/Form/Annotation/Edit.pm \
	blib/lib/MusicBrainz/Server/Form/Annotation/Edit.pm \
	lib/MusicBrainz/Server/Form/User/Contact.pm \
	blib/lib/MusicBrainz/Server/Form/User/Contact.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Tag.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Tag.pm \
	lib/MusicBrainz/Server/Adapter.pm \
	blib/lib/MusicBrainz/Server/Adapter.pm \
	lib/MusicBrainz/Server/dbmirror.pm \
	blib/lib/MusicBrainz/Server/dbmirror.pm \
	lib/MusicBrainz/Server/Form/Label/Create.pm \
	blib/lib/MusicBrainz/Server/Form/Label/Create.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE.pm \
	lib/MusicBrainz/Server/Form/Url/Edit.pm \
	blib/lib/MusicBrainz/Server/Form/Url/Edit.pm \
	lib/MusicBrainz/Server/Form/Track/Remove.pm \
	blib/lib/MusicBrainz/Server/Form/Track/Remove.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTNAME.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTNAME.pm \
	lib/MusicBrainz/Server/Model/Relation.pm \
	blib/lib/MusicBrainz/Server/Model/Relation.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_DISCID.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_DISCID.pm \
	lib/MusicBrainz/Server/Form/Search/External.pm \
	blib/lib/MusicBrainz/Server/Form/Search/External.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTISTALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTISTALIAS.pm \
	lib/MusicBrainz/Server/Model/Label.pm \
	blib/lib/MusicBrainz/Server/Model/Label.pm \
	lib/FreeDB.pm \
	blib/lib/FreeDB.pm \
	lib/DBDefs.pm.default \
	blib/lib/DBDefs.pm.default \
	lib/MusicBrainz/Server/View/Email/Template.pm \
	blib/lib/MusicBrainz/Server/View/Email/Template.pm \
	lib/MusicBrainz/Server/ReleaseEvent.pm \
	blib/lib/MusicBrainz/Server/ReleaseEvent.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Label.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Label.pm \
	lib/MusicBrainz/Server/Model/Subscription.pm \
	blib/lib/MusicBrainz/Server/Model/Subscription.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_PUID.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_PUID.pm \
	lib/MusicBrainz/Server/Form/Artist/Merge.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/Merge.pm \
	lib/MusicBrainz/Server/Form/Relate/AddCCLicense.pm \
	blib/lib/MusicBrainz/Server/Form/Relate/AddCCLicense.pm \
	lib/MusicBrainz/Server/Release.pm \
	blib/lib/MusicBrainz/Server/Release.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK.pm \
	lib/MusicBrainz/Server/Authentication/Store.pm \
	blib/lib/MusicBrainz/Server/Authentication/Store.pm \
	lib/MusicBrainz/Server/Form/Alias.pm \
	blib/lib/MusicBrainz/Server/Form/Alias.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL_ANNOTATION.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASES.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASES.pm \
	lib/MusicBrainz/Server/Form/Label/RemoveAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Label/RemoveAlias.pm \
	lib/MusicBrainz/Server/LinkEntity.pm \
	blib/lib/MusicBrainz/Server/LinkEntity.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABELALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABELALIAS.pm \
	lib/MusicBrainz/Server/Form/Release/Remove.pm \
	blib/lib/MusicBrainz/Server/Form/Release/Remove.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_RELEASE_QUALITY.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_RELEASE_QUALITY.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK.pm \
	lib/MusicBrainz/Server/Replication.pm \
	blib/lib/MusicBrainz/Server/Replication.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNAME.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNAME.pm \
	lib/MusicBrainz/Server/Vote.pm \
	blib/lib/MusicBrainz/Server/Vote.pm \
	lib/MusicBrainz/Server/Form/Search/Query.pm \
	blib/lib/MusicBrainz/Server/Form/Search/Query.pm \
	lib/MusicBrainz/Server.pm \
	blib/lib/MusicBrainz/Server.pm \
	lib/MusicBrainz/Server/Controller/Browse.pm \
	blib/lib/MusicBrainz/Server/Controller/Browse.pm \
	lib/MusicBrainz/Server/ModBot.pm \
	blib/lib/MusicBrainz/Server/ModBot.pm \
	lib/RDF2.pm \
	blib/lib/RDF2.pm \
	lib/MusicBrainz/Server/Moderation/MOD_CHANGE_TRACK_ARTIST.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_TRACK_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Auth.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Auth.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE.pm \
	lib/MusicBrainz/Server/LinkType.pm \
	blib/lib/MusicBrainz/Server/LinkType.pm \
	lib/MusicBrainz/Server/Script.pm \
	blib/lib/MusicBrainz/Server/Script.pm \
	lib/MusicBrainz/Server/Filters.pm \
	blib/lib/MusicBrainz/Server/Filters.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_PUIDS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_PUIDS.pm \
	lib/QuerySupport.pm \
	blib/lib/QuerySupport.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABELALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABELALIAS.pm \
	lib/MusicBrainz/Server/Form/Label/Base.pm \
	blib/lib/MusicBrainz/Server/Form/Label/Base.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_TRACK.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_TRACK.pm \
	lib/MusicBrainz/Server/Form/Artist/AddAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/AddAlias.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_TYPE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_TYPE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTALIAS.pm \
	lib/mq_2_1.pl \
	blib/lib/mq_2_1.pl \
	lib/ModDefs.pm \
	blib/lib/ModDefs.pm \
	lib/UserPreference.pm \
	blib/lib/UserPreference.pm \
	lib/UserSubscription.pm \
	blib/lib/UserSubscription.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_LANGUAGE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_LANGUAGE.pm \
	lib/LocaleSaver.pm \
	blib/lib/LocaleSaver.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_LABEL.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_LABEL.pm \
	lib/MusicBrainz/Server/Form/Search/Simple.pm \
	blib/lib/MusicBrainz/Server/Form/Search/Simple.pm \
	lib/MusicBrainz/Server/Form/Field/Time.pm \
	blib/lib/MusicBrainz/Server/Form/Field/Time.pm \
	lib/MusicBrainz/Server/AutomodElection.pm \
	blib/lib/MusicBrainz/Server/AutomodElection.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK.pm \
	lib/MusicBrainz/Server/Model/Url.pm \
	blib/lib/MusicBrainz/Server/Model/Url.pm \
	lib/MusicBrainz/Server/Action/Form.pm \
	blib/lib/MusicBrainz/Server/Action/Form.pm \
	lib/Insert.pm \
	blib/lib/Insert.pm \
	lib/MusicBrainz/Server/Form/User/Login.pm \
	blib/lib/MusicBrainz/Server/Form/User/Login.pm \
	lib/MusicBrainz/Server/Form/Label/EditAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Label/EditAlias.pm \
	lib/MusicBrainz/Server/Controller/User.pm \
	blib/lib/MusicBrainz/Server/Controller/User.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTISTALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTISTALIAS.pm \
	lib/MusicBrainz/Server/Form/Artist/AddNonAlbum.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/AddNonAlbum.pm \
	lib/MusicBrainz/Server/Form/Release/Move.pm \
	blib/lib/MusicBrainz/Server/Form/Release/Move.pm \
	lib/MusicBrainz/Server/Controller/Track.pm \
	blib/lib/MusicBrainz/Server/Controller/Track.pm \
	lib/MusicBrainz/Server/Form/Artist/RemoveAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/RemoveAlias.pm \
	lib/MusicBrainz/Server/Controller.pm \
	blib/lib/MusicBrainz/Server/Controller.pm \
	lib/MusicBrainz/Server/Controller/Doc.pm \
	blib/lib/MusicBrainz/Server/Controller/Doc.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_ANNOTATION.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE_EVENTS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE_EVENTS.pm \
	lib/MusicBrainz/Server/Form/Artist/Create.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/Create.pm \
	lib/MusicBrainz/Server/Controller/Root.pm \
	blib/lib/MusicBrainz/Server/Controller/Root.pm \
	lib/MusicBrainz/Server/Controller/Label.pm \
	blib/lib/MusicBrainz/Server/Controller/Label.pm \
	lib/MusicBrainz/Server/Form/DataQuality.pm \
	blib/lib/MusicBrainz/Server/Form/DataQuality.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Common.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Common.pm \
	lib/MusicBrainz/Server/WikiTransclusion.pm \
	blib/lib/MusicBrainz/Server/WikiTransclusion.pm \
	lib/MusicBrainz/Server/Controller/Search.pm \
	blib/lib/MusicBrainz/Server/Controller/Search.pm \
	lib/MusicBrainz/Server/Artist.pm \
	blib/lib/MusicBrainz/Server/Artist.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTIST.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTIST.pm \
	lib/MusicBrainz/Server/DeferredUpdate.pm \
	blib/lib/MusicBrainz/Server/DeferredUpdate.pm \
	lib/MusicBrainz/Server/LuceneSearch.pm \
	blib/lib/MusicBrainz/Server/LuceneSearch.pm \
	lib/MusicBrainz/Server/RateLimit.pm \
	blib/lib/MusicBrainz/Server/RateLimit.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	lib/MusicBrainz/Server/Form/Track/Base.pm \
	blib/lib/MusicBrainz/Server/Form/Track/Base.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MAC_TO_SAC.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MAC_TO_SAC.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Artist.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Artist.pm \
	lib/MusicBrainz/Server/Controller/Artist.pm \
	blib/lib/MusicBrainz/Server/Controller/Artist.pm \
	lib/MusicBrainz/Server/Model/Moderation.pm \
	blib/lib/MusicBrainz/Server/Model/Moderation.pm \
	lib/MusicBrainz/Server/Model/Release.pm \
	blib/lib/MusicBrainz/Server/Model/Release.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST_ANNOTATION.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST_ANNOTATION.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_KV.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_KV.pm \
	lib/mq.pl \
	blib/lib/mq.pl \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS_OLD.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS_OLD.pm \
	lib/MusicBrainz/Server/Track.pm \
	blib/lib/MusicBrainz/Server/Track.pm \
	lib/MusicBrainz/Server/Country.pm \
	blib/lib/MusicBrainz/Server/Country.pm \
	lib/MusicBrainz/Server/Form/Release/EditTitle.pm \
	blib/lib/MusicBrainz/Server/Form/Release/EditTitle.pm \
	lib/MM_2_1.pm \
	blib/lib/MM_2_1.pm \
	lib/MusicBrainz/Server/Form/AddRelease/Tracks.pm \
	blib/lib/MusicBrainz/Server/Form/AddRelease/Tracks.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKTIME.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKTIME.pm \
	lib/Parser.pm \
	blib/lib/Parser.pm \
	lib/MusicBrainz/Server/Form/Track/Edit.pm \
	blib/lib/MusicBrainz/Server/Form/Track/Edit.pm \
	lib/MusicBrainz/Server/Form/Field/Compound.pm \
	blib/lib/MusicBrainz/Server/Form/Field/Compound.pm \
	lib/MusicBrainz/Server/Handlers/WS/Private/Lookup.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/Private/Lookup.pm \
	lib/MusicBrainz/Server/Form/AddRelease/TrackCount.pm \
	blib/lib/MusicBrainz/Server/Form/AddRelease/TrackCount.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABEL.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABEL.pm \
	lib/MusicBrainz/Server/Attribute.pm \
	blib/lib/MusicBrainz/Server/Attribute.pm \
	lib/MusicBrainz/Server/TRMGatewayHandler.pm \
	blib/lib/MusicBrainz/Server/TRMGatewayHandler.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/User.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/User.pm \
	lib/MusicBrainz/Server/Form/User/Register.pm \
	blib/lib/MusicBrainz/Server/Form/User/Register.pm \
	lib/MusicBrainz/Server/Form/Relate/Remove.pm \
	blib/lib/MusicBrainz/Server/Form/Relate/Remove.pm \
	lib/MusicBrainz/Server/Controller/Url.pm \
	blib/lib/MusicBrainz/Server/Controller/Url.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTSORTNAME.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTSORTNAME.pm \
	lib/MusicBrainz/Server/Form/Relate/Url.pm \
	blib/lib/MusicBrainz/Server/Form/Relate/Url.pm \
	lib/MusicBrainz/Server/View/Default.pm \
	blib/lib/MusicBrainz/Server/View/Default.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK.pm \
	lib/DebugLog.pm \
	blib/lib/DebugLog.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_ATTR.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_ANNOTATION.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_ANNOTATION.pm \
	lib/MusicBrainz/Server/Model.pm \
	blib/lib/MusicBrainz/Server/Model.pm \
	lib/MusicBrainz/Server/Form/Field/URL.pm \
	blib/lib/MusicBrainz/Server/Form/Field/URL.pm \
	lib/MusicBrainz/Server/Form/Artist/EditAlias.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/EditAlias.pm \
	lib/MusicBrainz/Server/PagedReport.pm \
	blib/lib/MusicBrainz/Server/PagedReport.pm \
	lib/MusicBrainz/Server/Model/Track.pm \
	blib/lib/MusicBrainz/Server/Model/Track.pm \
	lib/MusicBrainz/Server/Form/Artist/DataQuality.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/DataQuality.pm \
	lib/MusicBrainz/Server/Editor.pm \
	blib/lib/MusicBrainz/Server/Editor.pm \
	lib/MusicBrainz/Server/Controller/Moderation.pm \
	blib/lib/MusicBrainz/Server/Controller/Moderation.pm \
	lib/MusicBrainz/Server/Form.pm \
	blib/lib/MusicBrainz/Server/Form.pm \
	lib/MusicBrainz/Server/Controller/CdToc.pm \
	blib/lib/MusicBrainz/Server/Controller/CdToc.pm \
	lib/rdf.pl \
	blib/lib/rdf.pl \
	lib/MusicBrainz/Server/Form/Label/Merge.pm \
	blib/lib/MusicBrainz/Server/Form/Label/Merge.pm \
	lib/MusicBrainz/Server/Controller/Annotation.pm \
	blib/lib/MusicBrainz/Server/Controller/Annotation.pm \
	lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	blib/lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	lib/Moderation.pm \
	blib/lib/Moderation.pm \
	lib/MusicBrainz/Server/Form/Field/TrackNumber.pm \
	blib/lib/MusicBrainz/Server/Form/Field/TrackNumber.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_ATTR.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Form/Field/LabelCode.pm \
	blib/lib/MusicBrainz/Server/Form/Field/LabelCode.pm \
	lib/MusicBrainz/Server/Form/Artist/Edit.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/Edit.pm \
	lib/MusicBrainz/Server/LinkAttr.pm \
	blib/lib/MusicBrainz/Server/LinkAttr.pm \
	lib/MusicBrainz/Server/Form/Field/ReleaseEvent.pm \
	blib/lib/MusicBrainz/Server/Form/Field/ReleaseEvent.pm \
	lib/MusicBrainz/Server/Model/FreeDB.pm \
	blib/lib/MusicBrainz/Server/Model/FreeDB.pm \
	lib/MusicBrainz/Server/Tag.pm \
	blib/lib/MusicBrainz/Server/Tag.pm \
	lib/MusicBrainz/Server/DateTime.pm \
	blib/lib/MusicBrainz/Server/DateTime.pm \
	lib/MusicBrainz/Server/Controller/Relate.pm \
	blib/lib/MusicBrainz/Server/Controller/Relate.pm \
	lib/MM_2_0.pm \
	blib/lib/MM_2_0.pm \
	lib/MusicBrainz/Server/Form/Artist/Base.pm \
	blib/lib/MusicBrainz/Server/Form/Artist/Base.pm \
	lib/MusicBrainz/Server/Alias.pm \
	blib/lib/MusicBrainz/Server/Alias.pm \
	lib/SearchEngine.pm \
	blib/lib/SearchEngine.pm \
	lib/MusicBrainz/Server/Form/Field/Track.pm \
	blib/lib/MusicBrainz/Server/Form/Field/Track.pm \
	lib/MusicBrainz/Server/Form/Field/Date.pm \
	blib/lib/MusicBrainz/Server/Form/Field/Date.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_ATTR.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_ATTR.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTIST.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTIST.pm \
	lib/MusicBrainz/Server/Moderation/MOD_ADD_LABELALIAS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABELALIAS.pm \
	lib/MusicBrainz/Server/Form/User/EditProfile.pm \
	blib/lib/MusicBrainz/Server/Form/User/EditProfile.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE_MAC.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE_MAC.pm \
	lib/MusicBrainz/Server/Mason.pm \
	blib/lib/MusicBrainz/Server/Mason.pm \
	lib/Style.pm \
	blib/lib/Style.pm \
	lib/MusicBrainz/Server/Handlers.pm \
	blib/lib/MusicBrainz/Server/Handlers.pm \
	lib/MusicBrainz/Server/Form/Alias/Add.pm \
	blib/lib/MusicBrainz/Server/Form/Alias/Add.pm \
	lib/MusicBrainz/Server/Moderation/MOD_SET_RELEASE_DURATIONS.pm \
	blib/lib/MusicBrainz/Server/Moderation/MOD_SET_RELEASE_DURATIONS.pm \
	lib/MusicBrainz/Server/Label.pm \
	blib/lib/MusicBrainz/Server/Label.pm \
	lib/MusicBrainz/Server/Statistic.pm \
	blib/lib/MusicBrainz/Server/Statistic.pm \
	lib/MusicBrainz/Server/Form/Release/EditAttributes.pm \
	blib/lib/MusicBrainz/Server/Form/Release/EditAttributes.pm \
	lib/MusicBrainz/Server/Controller/Statistics.pm \
	blib/lib/MusicBrainz/Server/Controller/Statistics.pm \
	lib/MusicBrainz/Server/Handlers/WS/1/Release.pm \
	blib/lib/MusicBrainz/Server/Handlers/WS/1/Release.pm \
	lib/MusicBrainz/Server/Model/Annotation.pm \
	blib/lib/MusicBrainz/Server/Model/Annotation.pm \
	lib/MusicBrainz/Server/TRMGateway.pm \
	blib/lib/MusicBrainz/Server/TRMGateway.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.48
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$ARGV[0], $$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(SHELL) -c true
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) "-MExtUtils::Command" -e mkpath
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) "-MExtUtils::Command" -e eqtime
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install({@ARGV}, '\''$(VERBINST)'\'', 0, '\''$(UNINST)'\'');' --
DOC_INSTALL = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e perllocal_install
UNINSTALL = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e uninstall
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) "-MExtUtils::Command::MM" -e warn_if_old_packlist
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(PERLRUN) "-MExtUtils::MY" -e "MY->fixin(shift)"


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = musicbrainz
DISTVNAME = musicbrainz-0.01


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) 755 $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) 755 $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) 755 $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) 755 $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) 755 $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) 755 $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) 755 $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) 755 $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	script/musicbrainz_fastcgi.pl \
	script/musicbrainz_create.pl \
	script/musicbrainz_test.pl \
	script/musicbrainz_server.pl \
	script/musicbrainz_cgi.pl \
	lib/MusicBrainz/Server/Model/Artist.pm \
	lib/MusicBrainz/Server/Model/Relation.pm \
	lib/MusicBrainz/Server/Form/Field/Compound.pm \
	lib/UserPreference.pm \
	lib/LocaleSaver.pm \
	lib/MusicBrainz/Server/Form/User/Register.pm \
	lib/MusicBrainz/Server/Controller/Url.pm \
	lib/MusicBrainz/Server/Form/User/Login.pm \
	lib/MusicBrainz/Server/Controller/User.pm \
	lib/TableBase.pm \
	lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	lib/MusicBrainz/Server/Controller/Track.pm \
	lib/MusicBrainz/Server/Controller.pm \
	lib/MusicBrainz/Server/Model/Tag.pm \
	lib/MusicBrainz/Server/Controller/Root.pm \
	lib/MusicBrainz/Server/Controller/Moderation.pm \
	lib/MusicBrainz/Server/Controller/Label.pm \
	lib/MusicBrainz/Server/Form.pm \
	lib/MusicBrainz/Server/Form/DataQuality.pm \
	lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	lib/MusicBrainz/Server/Controller/Search.pm \
	lib/MusicBrainz/Server/Artist.pm \
	lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	lib/MusicBrainz/Server/Form/User/Preferences.pm \
	lib/MusicBrainz/Server/Cache.pm \
	lib/MusicBrainz/Server/RateLimit.pm \
	lib/MusicBrainz/Server/Controller/AddRelease.pm \
	lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	lib/MusicBrainz/Server.pm \
	lib/MusicBrainz/Server/Form/Artist/Base.pm \
	lib/MusicBrainz/Server/Controller/Tags.pm \
	lib/MusicBrainz/Server/Controller/Artist.pm \
	lib/MusicBrainz/Server/Model/Release.pm \
	lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	lib/MusicBrainz/Server/Alias.pm \
	lib/MusicBrainz/Server/Form/Field/Track.pm \
	lib/MusicBrainz/Server/Form/Field/Date.pm \
	lib/MusicBrainz/Server/Controller/Release.pm \
	lib/MusicBrainz/Server/Form/User/EditProfile.pm \
	lib/MusicBrainz/Server/Label.pm \
	lib/MusicBrainz/Server/Form/Label/Base.pm \
	lib/MusicBrainz/Server/Controller/Statistics.pm \
	lib/MusicBrainz/Server/Adapter.pm
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  script/musicbrainz_fastcgi.pl $(INST_MAN1DIR)/musicbrainz_fastcgi.pl.$(MAN1EXT) \
	  script/musicbrainz_create.pl $(INST_MAN1DIR)/musicbrainz_create.pl.$(MAN1EXT) \
	  script/musicbrainz_test.pl $(INST_MAN1DIR)/musicbrainz_test.pl.$(MAN1EXT) \
	  script/musicbrainz_server.pl $(INST_MAN1DIR)/musicbrainz_server.pl.$(MAN1EXT) \
	  script/musicbrainz_cgi.pl $(INST_MAN1DIR)/musicbrainz_cgi.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/MusicBrainz/Server/Model/Artist.pm $(INST_MAN3DIR)/MusicBrainz::Server::Model::Artist.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Model/Relation.pm $(INST_MAN3DIR)/MusicBrainz::Server::Model::Relation.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/Field/Compound.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::Field::Compound.$(MAN3EXT) \
	  lib/UserPreference.pm $(INST_MAN3DIR)/UserPreference.$(MAN3EXT) \
	  lib/LocaleSaver.pm $(INST_MAN3DIR)/LocaleSaver.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/Register.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::Register.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Url.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Url.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/Login.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::Login.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/User.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::User.$(MAN3EXT) \
	  lib/TableBase.pm $(INST_MAN3DIR)/TableBase.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm $(INST_MAN3DIR)/MusicBrainz::Server::Moderation::MOD_EDIT_RELEASE_ATTRS.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Track.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Track.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Model/Tag.pm $(INST_MAN3DIR)/MusicBrainz::Server::Model::Tag.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Root.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Root.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Moderation.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Moderation.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Label.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Label.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/DataQuality.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::DataQuality.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/ChangePassword.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::ChangePassword.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Search.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Search.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Artist.pm $(INST_MAN3DIR)/MusicBrainz::Server::Artist.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm $(INST_MAN3DIR)/MusicBrainz::Server::Moderation::MOD_MOVE_DISCID.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/Preferences.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::Preferences.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Cache.pm $(INST_MAN3DIR)/MusicBrainz::Server::Cache.$(MAN3EXT) \
	  lib/MusicBrainz/Server/RateLimit.pm $(INST_MAN3DIR)/MusicBrainz::Server::RateLimit.$(MAN3EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/MusicBrainz/Server/Controller/AddRelease.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::AddRelease.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm $(INST_MAN3DIR)/MusicBrainz::Server::Moderation::MOD_REMOVE_DISCID.$(MAN3EXT) \
	  lib/MusicBrainz/Server.pm $(INST_MAN3DIR)/MusicBrainz::Server.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/Artist/Base.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::Artist::Base.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Tags.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Tags.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Artist.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Artist.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Model/Release.pm $(INST_MAN3DIR)/MusicBrainz::Server::Model::Release.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/ForgotPassword.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::ForgotPassword.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Alias.pm $(INST_MAN3DIR)/MusicBrainz::Server::Alias.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/Field/Track.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::Field::Track.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/Field/Date.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::Field::Date.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Release.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Release.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/User/EditProfile.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::User::EditProfile.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Label.pm $(INST_MAN3DIR)/MusicBrainz::Server::Label.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Form/Label/Base.pm $(INST_MAN3DIR)/MusicBrainz::Server::Form::Label::Base.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Controller/Statistics.pm $(INST_MAN3DIR)/MusicBrainz::Server::Controller::Statistics.$(MAN3EXT) \
	  lib/MusicBrainz/Server/Adapter.pm $(INST_MAN3DIR)/MusicBrainz::Server::Adapter.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/musicbrainz_cgi.pl script/musicbrainz_create.pl script/musicbrainz_fastcgi.pl script/musicbrainz_server.pl script/musicbrainz_test.pl

pure_all :: $(INST_SCRIPT)/musicbrainz_fastcgi.pl $(INST_SCRIPT)/musicbrainz_create.pl $(INST_SCRIPT)/musicbrainz_test.pl $(INST_SCRIPT)/musicbrainz_server.pl $(INST_SCRIPT)/musicbrainz_cgi.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/musicbrainz_fastcgi.pl $(INST_SCRIPT)/musicbrainz_create.pl \
	  $(INST_SCRIPT)/musicbrainz_test.pl $(INST_SCRIPT)/musicbrainz_server.pl \
	  $(INST_SCRIPT)/musicbrainz_cgi.pl 

$(INST_SCRIPT)/musicbrainz_fastcgi.pl : script/musicbrainz_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/musicbrainz_fastcgi.pl
	$(CP) script/musicbrainz_fastcgi.pl $(INST_SCRIPT)/musicbrainz_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/musicbrainz_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/musicbrainz_fastcgi.pl

$(INST_SCRIPT)/musicbrainz_create.pl : script/musicbrainz_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/musicbrainz_create.pl
	$(CP) script/musicbrainz_create.pl $(INST_SCRIPT)/musicbrainz_create.pl
	$(FIXIN) $(INST_SCRIPT)/musicbrainz_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/musicbrainz_create.pl

$(INST_SCRIPT)/musicbrainz_test.pl : script/musicbrainz_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/musicbrainz_test.pl
	$(CP) script/musicbrainz_test.pl $(INST_SCRIPT)/musicbrainz_test.pl
	$(FIXIN) $(INST_SCRIPT)/musicbrainz_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/musicbrainz_test.pl

$(INST_SCRIPT)/musicbrainz_server.pl : script/musicbrainz_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/musicbrainz_server.pl
	$(CP) script/musicbrainz_server.pl $(INST_SCRIPT)/musicbrainz_server.pl
	$(FIXIN) $(INST_SCRIPT)/musicbrainz_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/musicbrainz_server.pl

$(INST_SCRIPT)/musicbrainz_cgi.pl : script/musicbrainz_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/musicbrainz_cgi.pl
	$(CP) script/musicbrainz_cgi.pl $(INST_SCRIPT)/musicbrainz_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/musicbrainz_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/musicbrainz_cgi.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  *$(LIB_EXT) core \
	  core.[0-9] $(INST_ARCHAUTODIR)/extralibs.all \
	  core.[0-9][0-9] $(BASEEXT).bso \
	  pm_to_blib.ts core.[0-9][0-9][0-9][0-9] \
	  $(BASEEXT).x $(BOOTSTRAP) \
	  perl$(EXE_EXT) tmon.out \
	  *$(OBJ_EXT) pm_to_blib \
	  $(INST_ARCHAUTODIR)/extralibs.ld blibdirs.ts \
	  core.[0-9][0-9][0-9][0-9][0-9] *perl.core \
	  core.*perl.*.? $(MAKE_APERL_FILE) \
	  perl $(BASEEXT).def \
	  core.[0-9][0-9][0-9] mon.out \
	  lib$(BASEEXT).def perlmain.c \
	  perl.exe so_locations \
	  $(BASEEXT).exp 
	- $(RM_RF) \
	  META.yml blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{META.yml} => q{Module meta-data (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add META.yml to MANIFEST: $${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: all pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: all pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: all pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: all pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install ::
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install ::
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLVENDORLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	false



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/01app.t t/02pod.t t/03podcoverage.t t/controller_Main.t t/controller_User.t t/replace_ar_attribs.t t/taglookup_lucene_query.t t/view_Default.t t/view_Main.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="0,01,0,0">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <TITLE>$(DISTNAME)</TITLE>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Catalyst based application</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Catalyst developer</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Algorithm-Diff" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Cache-Memcached" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Action-RenderView" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Component-ACCEPT_CONTEXT" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-Authentication" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-ConfigLoader" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-Form-Processor" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-Session-State-Cookie" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-Session-Store-FastMmap" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-StackTrace" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Plugin-Static-Simple" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-Runtime" VERSION="5,71000,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-View-Email" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Catalyst-View-TT" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="DBD-Pg" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="DBI" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Data-Page" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Date-Calc" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Devel-Peek" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Digest-MD5" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Digest-SHA1" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Email-Date-Format" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Email-Valid" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="ExtUtils-MakeMaker" VERSION="6,48,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Form-Processor" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="JSON" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="MIME-Lite" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Moose" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="OSSP-uuid" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="String-ShellQuote" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="String-Similarity" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Text-Unaccent" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="Text-WikiFormat" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="XML-Feed" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="YAML" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <DEPENDENCY NAME="parent" VERSION="0,0,0,0" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <OS NAME="$(OSNAME)" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="x86_64-linux-gnu-thread-multi-5.1" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Database.pm blib/lib/MusicBrainz/Server/Database.pm \
	  lib/MusicBrainz/Server/Model/Artist.pm blib/lib/MusicBrainz/Server/Model/Artist.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Track.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Track.pm \
	  lib/MusicBrainz/Server/Model/User.pm blib/lib/MusicBrainz/Server/Model/User.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_NAME.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_NAME.pm \
	  lib/MusicBrainz/Server/Model/CdToc.pm blib/lib/MusicBrainz/Server/Model/CdToc.pm \
	  lib/MusicBrainz/Server/ReleaseCDTOC.pm blib/lib/MusicBrainz/Server/ReleaseCDTOC.pm \
	  lib/MusicBrainz/Server/Annotation.pm blib/lib/MusicBrainz/Server/Annotation.pm \
	  lib/MusicBrainz/Server/Form/Release/ConvertToSingleArtist.pm blib/lib/MusicBrainz/Server/Form/Release/ConvertToSingleArtist.pm \
	  lib/MusicBrainz/Server/Form/Release/DataQuality.pm blib/lib/MusicBrainz/Server/Form/Release/DataQuality.pm \
	  lib/MusicBrainz/Server/PUID.pm blib/lib/MusicBrainz/Server/PUID.pm \
	  lib/TaggerSupport.pm blib/lib/TaggerSupport.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_SAC_TO_MAC.pm blib/lib/MusicBrainz/Server/Moderation/MOD_SAC_TO_MAC.pm \
	  lib/MusicBrainz/Server/Form/Field/Email.pm blib/lib/MusicBrainz/Server/Form/Field/Email.pm \
	  lib/MusicBrainz/Server/Model/Alias.pm blib/lib/MusicBrainz/Server/Model/Alias.pm \
	  lib/MusicBrainz/Server/Markup.pm blib/lib/MusicBrainz/Server/Markup.pm \
	  lib/MusicBrainz/Server/URL.pm blib/lib/MusicBrainz/Server/URL.pm \
	  lib/MusicBrainz/Server/Model/Feeds.pm blib/lib/MusicBrainz/Server/Model/Feeds.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST.pm \
	  lib/TableBase.pm blib/lib/TableBase.pm \
	  lib/MusicBrainz/Server/Model/Documentation.pm blib/lib/MusicBrainz/Server/Model/Documentation.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABEL.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABEL.pm \
	  lib/Sql.pm blib/lib/Sql.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MERGE_ARTIST.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_ARTIST.pm \
	  lib/MusicBrainz/Server/Controller/Review.pm blib/lib/MusicBrainz/Server/Controller/Review.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNUM.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNUM.pm \
	  lib/MusicBrainz/Server/Model/Tag.pm blib/lib/MusicBrainz/Server/Model/Tag.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_TYPE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_TYPE.pm \
	  lib/MusicBrainz/Server/LogFile.pm blib/lib/MusicBrainz/Server/LogFile.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/ModerationNote.pm blib/lib/MusicBrainz/Server/ModerationNote.pm \
	  lib/MusicBrainz/Server/Form/Track/ChangeArtist.pm blib/lib/MusicBrainz/Server/Form/Track/ChangeArtist.pm \
	  lib/MusicBrainz/Server/Link.pm blib/lib/MusicBrainz/Server/Link.pm \
	  lib/MusicBrainz/Server/Controller/FreeDB.pm blib/lib/MusicBrainz/Server/Controller/FreeDB.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MOVE_DISCID.pm \
	  lib/MusicBrainz/Server/Form/User/Preferences.pm blib/lib/MusicBrainz/Server/Form/User/Preferences.pm \
	  lib/MusicBrainz/Server/Cache.pm blib/lib/MusicBrainz/Server/Cache.pm \
	  lib/MM.pm blib/lib/MM.pm \
	  lib/MusicBrainz/Server/CDTOC.pm blib/lib/MusicBrainz/Server/CDTOC.pm \
	  lib/MusicBrainz/Server/Controller/AddRelease.pm blib/lib/MusicBrainz/Server/Controller/AddRelease.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_TYPE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_TYPE.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_EVENTS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_EVENTS.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_URL.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_URL.pm \
	  lib/rdf_2_1.pl blib/lib/rdf_2_1.pl \
	  lib/MusicBrainz/Server/Form/Moderation/AddNote.pm blib/lib/MusicBrainz/Server/Form/Moderation/AddNote.pm \
	  lib/MusicBrainz/Server/Form/Tag/Tags.pm blib/lib/MusicBrainz/Server/Form/Tag/Tags.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_CHANGE_WIKIDOC.pm blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_WIKIDOC.pm \
	  lib/MusicBrainz/Server/Controller/Tags.pm blib/lib/MusicBrainz/Server/Controller/Tags.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MOVE_RELEASE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MOVE_RELEASE.pm \
	  lib/MusicBrainz/Server/Form/User/ForgotPassword.pm blib/lib/MusicBrainz/Server/Form/User/ForgotPassword.pm \
	  lib/MusicBrainz/Server/Validation.pm blib/lib/MusicBrainz/Server/Validation.pm \
	  lib/MusicBrainz/Server/ReportScript.pm blib/lib/MusicBrainz/Server/ReportScript.pm \
	  lib/MusicBrainz/Server/Controller/Release.pm blib/lib/MusicBrainz/Server/Controller/Release.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_CHANGE_ARTIST_QUALITY.pm blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_ARTIST_QUALITY.pm \
	  lib/MusicBrainz/Server/Form/Label/AddAlias.pm blib/lib/MusicBrainz/Server/Form/Label/AddAlias.pm \
	  lib/MusicBrainz/Server/Language.pm blib/lib/MusicBrainz/Server/Language.pm \
	  lib/MusicBrainz/Server/CoverArt.pm blib/lib/MusicBrainz/Server/CoverArt.pm \
	  lib/MusicBrainz/Server/Form/Label/Edit.pm blib/lib/MusicBrainz/Server/Form/Label/Edit.pm \
	  lib/MusicBrainz.pm blib/lib/MusicBrainz.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Form/Annotation/Edit.pm blib/lib/MusicBrainz/Server/Form/Annotation/Edit.pm \
	  lib/MusicBrainz/Server/Form/User/Contact.pm blib/lib/MusicBrainz/Server/Form/User/Contact.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Tag.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Tag.pm \
	  lib/MusicBrainz/Server/Adapter.pm blib/lib/MusicBrainz/Server/Adapter.pm \
	  lib/MusicBrainz/Server/dbmirror.pm blib/lib/MusicBrainz/Server/dbmirror.pm \
	  lib/MusicBrainz/Server/Form/Label/Create.pm blib/lib/MusicBrainz/Server/Form/Label/Create.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE.pm \
	  lib/MusicBrainz/Server/Form/Url/Edit.pm blib/lib/MusicBrainz/Server/Form/Url/Edit.pm \
	  lib/MusicBrainz/Server/Form/Track/Remove.pm blib/lib/MusicBrainz/Server/Form/Track/Remove.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTNAME.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTNAME.pm \
	  lib/MusicBrainz/Server/Model/Relation.pm blib/lib/MusicBrainz/Server/Model/Relation.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_DISCID.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_DISCID.pm \
	  lib/MusicBrainz/Server/Form/Search/External.pm blib/lib/MusicBrainz/Server/Form/Search/External.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTISTALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTISTALIAS.pm \
	  lib/MusicBrainz/Server/Model/Label.pm blib/lib/MusicBrainz/Server/Model/Label.pm \
	  lib/FreeDB.pm blib/lib/FreeDB.pm \
	  lib/DBDefs.pm.default blib/lib/DBDefs.pm.default \
	  lib/MusicBrainz/Server/View/Email/Template.pm blib/lib/MusicBrainz/Server/View/Email/Template.pm \
	  lib/MusicBrainz/Server/ReleaseEvent.pm blib/lib/MusicBrainz/Server/ReleaseEvent.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Label.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Label.pm \
	  lib/MusicBrainz/Server/Model/Subscription.pm blib/lib/MusicBrainz/Server/Model/Subscription.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_PUID.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_PUID.pm \
	  lib/MusicBrainz/Server/Form/Artist/Merge.pm blib/lib/MusicBrainz/Server/Form/Artist/Merge.pm \
	  lib/MusicBrainz/Server/Form/Relate/AddCCLicense.pm blib/lib/MusicBrainz/Server/Form/Relate/AddCCLicense.pm \
	  lib/MusicBrainz/Server/Release.pm blib/lib/MusicBrainz/Server/Release.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_ATTRS.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK.pm \
	  lib/MusicBrainz/Server/Authentication/Store.pm blib/lib/MusicBrainz/Server/Authentication/Store.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Form/Alias.pm blib/lib/MusicBrainz/Server/Form/Alias.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL_ANNOTATION.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABEL_ANNOTATION.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASES.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASES.pm \
	  lib/MusicBrainz/Server/Form/Label/RemoveAlias.pm blib/lib/MusicBrainz/Server/Form/Label/RemoveAlias.pm \
	  lib/MusicBrainz/Server/LinkEntity.pm blib/lib/MusicBrainz/Server/LinkEntity.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABELALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LABELALIAS.pm \
	  lib/MusicBrainz/Server/Form/Release/Remove.pm blib/lib/MusicBrainz/Server/Form/Release/Remove.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_CHANGE_RELEASE_QUALITY.pm blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_RELEASE_QUALITY.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK.pm \
	  lib/MusicBrainz/Server/Replication.pm blib/lib/MusicBrainz/Server/Replication.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNAME.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKNAME.pm \
	  lib/MusicBrainz/Server/Vote.pm blib/lib/MusicBrainz/Server/Vote.pm \
	  lib/MusicBrainz/Server/Form/Search/Query.pm blib/lib/MusicBrainz/Server/Form/Search/Query.pm \
	  lib/MusicBrainz/Server.pm blib/lib/MusicBrainz/Server.pm \
	  lib/MusicBrainz/Server/Controller/Browse.pm blib/lib/MusicBrainz/Server/Controller/Browse.pm \
	  lib/MusicBrainz/Server/ModBot.pm blib/lib/MusicBrainz/Server/ModBot.pm \
	  lib/RDF2.pm blib/lib/RDF2.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_CHANGE_TRACK_ARTIST.pm blib/lib/MusicBrainz/Server/Moderation/MOD_CHANGE_TRACK_ARTIST.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Auth.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Auth.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE.pm \
	  lib/MusicBrainz/Server/LinkType.pm blib/lib/MusicBrainz/Server/LinkType.pm \
	  lib/MusicBrainz/Server/Script.pm blib/lib/MusicBrainz/Server/Script.pm \
	  lib/MusicBrainz/Server/Filters.pm blib/lib/MusicBrainz/Server/Filters.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_PUIDS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_PUIDS.pm \
	  lib/QuerySupport.pm blib/lib/QuerySupport.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABELALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABELALIAS.pm \
	  lib/MusicBrainz/Server/Form/Label/Base.pm blib/lib/MusicBrainz/Server/Form/Label/Base.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_TRACK.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_TRACK.pm \
	  lib/MusicBrainz/Server/Form/Artist/AddAlias.pm blib/lib/MusicBrainz/Server/Form/Artist/AddAlias.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_TYPE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_TYPE.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTALIAS.pm \
	  lib/mq_2_1.pl blib/lib/mq_2_1.pl \
	  lib/ModDefs.pm blib/lib/ModDefs.pm \
	  lib/UserPreference.pm blib/lib/UserPreference.pm \
	  lib/UserSubscription.pm blib/lib/UserSubscription.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_LANGUAGE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_LANGUAGE.pm \
	  lib/LocaleSaver.pm blib/lib/LocaleSaver.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MERGE_LABEL.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_LABEL.pm \
	  lib/MusicBrainz/Server/Form/Search/Simple.pm blib/lib/MusicBrainz/Server/Form/Search/Simple.pm \
	  lib/MusicBrainz/Server/Form/Field/Time.pm blib/lib/MusicBrainz/Server/Form/Field/Time.pm \
	  lib/MusicBrainz/Server/AutomodElection.pm blib/lib/MusicBrainz/Server/AutomodElection.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK.pm \
	  lib/MusicBrainz/Server/Model/Url.pm blib/lib/MusicBrainz/Server/Model/Url.pm \
	  lib/MusicBrainz/Server/Action/Form.pm blib/lib/MusicBrainz/Server/Action/Form.pm \
	  lib/Insert.pm blib/lib/Insert.pm \
	  lib/MusicBrainz/Server/Form/User/Login.pm blib/lib/MusicBrainz/Server/Form/User/Login.pm \
	  lib/MusicBrainz/Server/Form/Label/EditAlias.pm blib/lib/MusicBrainz/Server/Form/Label/EditAlias.pm \
	  lib/MusicBrainz/Server/Controller/User.pm blib/lib/MusicBrainz/Server/Controller/User.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTISTALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTISTALIAS.pm \
	  lib/MusicBrainz/Server/Form/Artist/AddNonAlbum.pm blib/lib/MusicBrainz/Server/Form/Artist/AddNonAlbum.pm \
	  lib/MusicBrainz/Server/Form/Release/Move.pm blib/lib/MusicBrainz/Server/Form/Release/Move.pm \
	  lib/MusicBrainz/Server/Controller/Track.pm blib/lib/MusicBrainz/Server/Controller/Track.pm \
	  lib/MusicBrainz/Server/Form/Artist/RemoveAlias.pm blib/lib/MusicBrainz/Server/Form/Artist/RemoveAlias.pm \
	  lib/MusicBrainz/Server/Controller.pm blib/lib/MusicBrainz/Server/Controller.pm \
	  lib/MusicBrainz/Server/Controller/Doc.pm blib/lib/MusicBrainz/Server/Controller/Doc.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_ANNOTATION.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_ANNOTATION.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE_EVENTS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE_EVENTS.pm \
	  lib/MusicBrainz/Server/Form/Artist/Create.pm blib/lib/MusicBrainz/Server/Form/Artist/Create.pm \
	  lib/MusicBrainz/Server/Controller/Root.pm blib/lib/MusicBrainz/Server/Controller/Root.pm \
	  lib/MusicBrainz/Server/Controller/Label.pm blib/lib/MusicBrainz/Server/Controller/Label.pm \
	  lib/MusicBrainz/Server/Form/DataQuality.pm blib/lib/MusicBrainz/Server/Form/DataQuality.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Common.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Common.pm \
	  lib/MusicBrainz/Server/WikiTransclusion.pm blib/lib/MusicBrainz/Server/WikiTransclusion.pm \
	  lib/MusicBrainz/Server/Controller/Search.pm blib/lib/MusicBrainz/Server/Controller/Search.pm \
	  lib/MusicBrainz/Server/Artist.pm blib/lib/MusicBrainz/Server/Artist.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTIST.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_ARTIST.pm \
	  lib/MusicBrainz/Server/DeferredUpdate.pm blib/lib/MusicBrainz/Server/DeferredUpdate.pm \
	  lib/MusicBrainz/Server/LuceneSearch.pm blib/lib/MusicBrainz/Server/LuceneSearch.pm \
	  lib/MusicBrainz/Server/RateLimit.pm blib/lib/MusicBrainz/Server/RateLimit.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_RELEASE.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_DISCID.pm \
	  lib/MusicBrainz/Server/Form/Track/Base.pm blib/lib/MusicBrainz/Server/Form/Track/Base.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_MAC_TO_SAC.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MAC_TO_SAC.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Artist.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Artist.pm \
	  lib/MusicBrainz/Server/Controller/Artist.pm blib/lib/MusicBrainz/Server/Controller/Artist.pm \
	  lib/MusicBrainz/Server/Model/Moderation.pm blib/lib/MusicBrainz/Server/Model/Moderation.pm \
	  lib/MusicBrainz/Server/Model/Release.pm blib/lib/MusicBrainz/Server/Model/Release.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST_ANNOTATION.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_ARTIST_ANNOTATION.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_KV.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK_KV.pm \
	  lib/mq.pl blib/lib/mq.pl \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS_OLD.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_RELEASE_EVENTS_OLD.pm \
	  lib/MusicBrainz/Server/Track.pm blib/lib/MusicBrainz/Server/Track.pm \
	  lib/MusicBrainz/Server/Country.pm blib/lib/MusicBrainz/Server/Country.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Form/Release/EditTitle.pm blib/lib/MusicBrainz/Server/Form/Release/EditTitle.pm \
	  lib/MM_2_1.pm blib/lib/MM_2_1.pm \
	  lib/MusicBrainz/Server/Form/AddRelease/Tracks.pm blib/lib/MusicBrainz/Server/Form/AddRelease/Tracks.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKTIME.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_TRACKTIME.pm \
	  lib/Parser.pm blib/lib/Parser.pm \
	  lib/MusicBrainz/Server/Form/Track/Edit.pm blib/lib/MusicBrainz/Server/Form/Track/Edit.pm \
	  lib/MusicBrainz/Server/Form/Field/Compound.pm blib/lib/MusicBrainz/Server/Form/Field/Compound.pm \
	  lib/MusicBrainz/Server/Handlers/WS/Private/Lookup.pm blib/lib/MusicBrainz/Server/Handlers/WS/Private/Lookup.pm \
	  lib/MusicBrainz/Server/Form/AddRelease/TrackCount.pm blib/lib/MusicBrainz/Server/Form/AddRelease/TrackCount.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABEL.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LABEL.pm \
	  lib/MusicBrainz/Server/Attribute.pm blib/lib/MusicBrainz/Server/Attribute.pm \
	  lib/MusicBrainz/Server/TRMGatewayHandler.pm blib/lib/MusicBrainz/Server/TRMGatewayHandler.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/User.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/User.pm \
	  lib/MusicBrainz/Server/Form/User/Register.pm blib/lib/MusicBrainz/Server/Form/User/Register.pm \
	  lib/MusicBrainz/Server/Form/Relate/Remove.pm blib/lib/MusicBrainz/Server/Form/Relate/Remove.pm \
	  lib/MusicBrainz/Server/Controller/Url.pm blib/lib/MusicBrainz/Server/Controller/Url.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTSORTNAME.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTISTSORTNAME.pm \
	  lib/MusicBrainz/Server/Form/Relate/Url.pm blib/lib/MusicBrainz/Server/Form/Relate/Url.pm \
	  lib/MusicBrainz/Server/View/Default.pm blib/lib/MusicBrainz/Server/View/Default.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_TRACK.pm \
	  lib/DebugLog.pm blib/lib/DebugLog.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_ATTR.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LINK_ATTR.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_ANNOTATION.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_RELEASE_ANNOTATION.pm \
	  lib/MusicBrainz/Server/Model.pm blib/lib/MusicBrainz/Server/Model.pm \
	  lib/MusicBrainz/Server/Form/Field/URL.pm blib/lib/MusicBrainz/Server/Form/Field/URL.pm \
	  lib/MusicBrainz/Server/Form/Artist/EditAlias.pm blib/lib/MusicBrainz/Server/Form/Artist/EditAlias.pm \
	  lib/MusicBrainz/Server/PagedReport.pm blib/lib/MusicBrainz/Server/PagedReport.pm \
	  lib/MusicBrainz/Server/Model/Track.pm blib/lib/MusicBrainz/Server/Model/Track.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Form/Artist/DataQuality.pm blib/lib/MusicBrainz/Server/Form/Artist/DataQuality.pm \
	  lib/MusicBrainz/Server/Editor.pm blib/lib/MusicBrainz/Server/Editor.pm \
	  lib/MusicBrainz/Server/Controller/Moderation.pm blib/lib/MusicBrainz/Server/Controller/Moderation.pm \
	  lib/MusicBrainz/Server/Form.pm blib/lib/MusicBrainz/Server/Form.pm \
	  lib/MusicBrainz/Server/Controller/CdToc.pm blib/lib/MusicBrainz/Server/Controller/CdToc.pm \
	  lib/rdf.pl blib/lib/rdf.pl \
	  lib/MusicBrainz/Server/Form/Label/Merge.pm blib/lib/MusicBrainz/Server/Form/Label/Merge.pm \
	  lib/MusicBrainz/Server/Controller/Annotation.pm blib/lib/MusicBrainz/Server/Controller/Annotation.pm \
	  lib/MusicBrainz/Server/Form/User/ChangePassword.pm blib/lib/MusicBrainz/Server/Form/User/ChangePassword.pm \
	  lib/Moderation.pm blib/lib/Moderation.pm \
	  lib/MusicBrainz/Server/Form/Field/TrackNumber.pm blib/lib/MusicBrainz/Server/Form/Field/TrackNumber.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_ATTR.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_LINK_ATTR.pm \
	  lib/MusicBrainz/Server/Form/Field/LabelCode.pm blib/lib/MusicBrainz/Server/Form/Field/LabelCode.pm \
	  lib/MusicBrainz/Server/Form/Artist/Edit.pm blib/lib/MusicBrainz/Server/Form/Artist/Edit.pm \
	  lib/MusicBrainz/Server/LinkAttr.pm blib/lib/MusicBrainz/Server/LinkAttr.pm \
	  lib/MusicBrainz/Server/Form/Field/ReleaseEvent.pm blib/lib/MusicBrainz/Server/Form/Field/ReleaseEvent.pm \
	  lib/MusicBrainz/Server/Model/FreeDB.pm blib/lib/MusicBrainz/Server/Model/FreeDB.pm \
	  lib/MusicBrainz/Server/Tag.pm blib/lib/MusicBrainz/Server/Tag.pm \
	  lib/MusicBrainz/Server/DateTime.pm blib/lib/MusicBrainz/Server/DateTime.pm \
	  lib/MusicBrainz/Server/Controller/Relate.pm blib/lib/MusicBrainz/Server/Controller/Relate.pm \
	  lib/MM_2_0.pm blib/lib/MM_2_0.pm \
	  lib/MusicBrainz/Server/Form/Artist/Base.pm blib/lib/MusicBrainz/Server/Form/Artist/Base.pm \
	  lib/MusicBrainz/Server/Alias.pm blib/lib/MusicBrainz/Server/Alias.pm \
	  lib/SearchEngine.pm blib/lib/SearchEngine.pm \
	  lib/MusicBrainz/Server/Form/Field/Track.pm blib/lib/MusicBrainz/Server/Form/Field/Track.pm \
	  lib/MusicBrainz/Server/Form/Field/Date.pm blib/lib/MusicBrainz/Server/Form/Field/Date.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_ATTR.pm blib/lib/MusicBrainz/Server/Moderation/MOD_REMOVE_LINK_ATTR.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTIST.pm blib/lib/MusicBrainz/Server/Moderation/MOD_EDIT_ARTIST.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_ADD_LABELALIAS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_ADD_LABELALIAS.pm \
	  lib/MusicBrainz/Server/Form/User/EditProfile.pm blib/lib/MusicBrainz/Server/Form/User/EditProfile.pm 
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', '\''$(PM_FILTER)'\'')' -- \
	  lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE_MAC.pm blib/lib/MusicBrainz/Server/Moderation/MOD_MERGE_RELEASE_MAC.pm \
	  lib/MusicBrainz/Server/Mason.pm blib/lib/MusicBrainz/Server/Mason.pm \
	  lib/Style.pm blib/lib/Style.pm \
	  lib/MusicBrainz/Server/Handlers.pm blib/lib/MusicBrainz/Server/Handlers.pm \
	  lib/MusicBrainz/Server/Form/Alias/Add.pm blib/lib/MusicBrainz/Server/Form/Alias/Add.pm \
	  lib/MusicBrainz/Server/Moderation/MOD_SET_RELEASE_DURATIONS.pm blib/lib/MusicBrainz/Server/Moderation/MOD_SET_RELEASE_DURATIONS.pm \
	  lib/MusicBrainz/Server/Label.pm blib/lib/MusicBrainz/Server/Label.pm \
	  lib/MusicBrainz/Server/Statistic.pm blib/lib/MusicBrainz/Server/Statistic.pm \
	  lib/MusicBrainz/Server/Form/Release/EditAttributes.pm blib/lib/MusicBrainz/Server/Form/Release/EditAttributes.pm \
	  lib/MusicBrainz/Server/Controller/Statistics.pm blib/lib/MusicBrainz/Server/Controller/Statistics.pm \
	  lib/MusicBrainz/Server/Handlers/WS/1/Release.pm blib/lib/MusicBrainz/Server/Handlers/WS/1/Release.pm \
	  lib/MusicBrainz/Server/Model/Annotation.pm blib/lib/MusicBrainz/Server/Model/Annotation.pm \
	  lib/MusicBrainz/Server/TRMGateway.pm blib/lib/MusicBrainz/Server/TRMGateway.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 0.75
# --- Module::Install::Admin::Makefile section:

realclean purge ::
	$(RM_F) $(DISTVNAME).tar$(SUFFIX)
	$(RM_RF) inc MANIFEST.bak _build
	$(PERL) -I. "-MModule::Install::Admin" -e "remove_meta()"

reset :: purge

upload :: test dist
	cpan-upload -verbose $(DISTVNAME).tar$(SUFFIX)

grok ::
	perldoc Module::Install

distsign ::
	cpansign -s

catalyst_par :: all
	$(NOECHO) $(PERL) -Ilib -Minc::Module::Install -MModule::Install::Catalyst -e"Catalyst::Module::Install::_catalyst_par( '', 'musicbrainz', { CLASSES => [], CORE => 0, ENGINE => 'CGI', MULTIARCH => 0, SCRIPT => '', USAGE => q## } )"
# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(PERL) Makefile.PL --config= --installdeps=Cache::Memcached,0,Catalyst::Component::ACCEPT_CONTEXT,0,Catalyst::Plugin::Form::Processor,0,Catalyst::Runtime,5.71000,Form::Processor,0,MIME::Lite,0,OSSP::uuid,0,String::ShellQuote,0,String::Similarity,0,Text::Unaccent,0,Text::WikiFormat,0,XML::Feed,0

