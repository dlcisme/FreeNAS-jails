#!/bin/sh

# functions to help installation
. ./functions.sh

# install radarr
Install_Package "radarr"

# NOTE:  FreeNAS installs user "Media" and group "Media when
#        the jail gets created
# pw groupadd 'media' -g '816'
# pw useradd 'media' -u '816' -g 'media'

#chown -R media:media /usr/local/share/sonarr

echo =====\> enable radarr start at boot
sysrc "radarr_enable=YES"

# add radarr user to media group
echo =====\> add "radarr" user to "media" group
pw groupmod media -m radarr
