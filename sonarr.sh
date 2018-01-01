#!/bin/sh

# functions to help installation
. ./functions.sh

# install sonarr
Install_Package "sonarr"

#pw user add media -c media -u 816 -d /nonexistent -s /usr/bin/nologin


#chown -R media:media /usr/local/share/sonarr

echo =====\> enable sonarr to start at boot
sysrc  "sonarr_enable=YES"

# add sonarr user to media group
echo =====\> add "sonarr" user to "media" group
pw groupmod media -m sonarr
