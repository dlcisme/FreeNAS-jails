#!/bin/sh

# functions to help installation
. ./functions.sh

# install sonarr
Install_Package "sonarr"

# NOTE:  FreeNAS installs user "Media" and group "Media when
#        the jail gets created
# pw groupadd 'media' -g '816'
# pw useradd 'media' -u '816' -g 'media'

#chown -R media:media /usr/local/share/sonarr

echo =====\> enable sonarr to start at boot
sysrc  "sonarr_enable=YES"

# add sonarr user to media group
echo =====\> add "sonarr" user to "media" group
pw groupmod media -m sonarr
