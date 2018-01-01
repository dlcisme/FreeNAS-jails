#!/bin/sh

# functions to help installation
. ./functions.sh

# install radarr
Install_Package "radarr"

#pw user add media -c media -u 816 -d /nonexistent -s /usr/bin/nologin


#chown -R media:media /usr/local/share/sonarr

echo =====\> enable radarr start at boot
sysrc "radarr_enable=YES"

# add radarr user to media group
echo =====\> add "radarr" user to "media" group
pw groupmod media -m radarr
