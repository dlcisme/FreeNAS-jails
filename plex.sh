#!/bin/sh

# goto http://localhost:32400/web

# go here for installation instructions for trakt add on
#https://github.com/trakt/Plex-Trakt-Scrobbler/wiki/

# Add the following lines to /etc/rc.conf to enable the Plex Media Server:
#
# plexmediaserver_enable="YES"
#
# plexmediaserver_support_path="/usr/local/plexdata" # Plex data: logs, media metadata, settings, etc
#
# plexmediaserver_tmp="/var/tmp/plex" # configure tmp directory used for the transcoding process if desired
#
# plexmediaserver_maxplugins="6" # Maximum number of background plugin procs. May have to raise in rare cases.
#


# functions to help installation
. ./functions.sh

_PLEXMEDIA_DATA_DIR=/app-data/Plex

# install plexmediaserver
Install_Package "plexmediaserver"

# make plexr the owner of app-data directory
Inform "make plex owner of $_PLEXMEDIA_DATA_DIR config directory"
chown -R plex:plex $_PLEXMEDIA_DATA_DIR

Inform "set plexmedia data dir to $_PLEXMEDIA_DATA_DIR"
sysrc "plexmediaserver_support_path=$_PLEXMEDIA_DATA_DIR"

Inform "enable plex to start at boot"
sysrc "plexmediaserver_enable=YES"


# install trakt plug-in

Inform "fetch trakt scrobbler"
fetch https://github.com/trakt/Plex-Trakt-Scrobbler/archive/master.zip -o Plex-Trakt-Scrobbler.zip

Inform "unzip trakt"
unzip Plex-Trakt-Scrobbler.zip

Inform "add trakt to plex plug-ins"
cp -r Plex-Trakt-Scrobbler-*/Trakttv.bundle "/usr/local/plexdata/Plex Media Server/Plug-ins/"

Inform "make plex owner of trakt plug-in"
chown -R plex:plex "/usr/local/plexdata/Plex Media Server/Plug-ins/Trakttv.bundle"

Inform "set trakt permissions"
chmod -R 770 "/usr/local/plexdata/Plex Media Server/Plug-ins/Trakttv.bundle"

