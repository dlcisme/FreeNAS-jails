#!/bin/sh



# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# jackett_enable:    Set to YES to enable jackett
#            Default: NO
# jackett_user:    The user account used to run the jackett daemon.
#            This is optional, however do not specifically set this to an
#            empty string as this will cause the daemon to run as root.
#            Default: jackett
# jackett_group:    The group account used to run the jackett daemon.
#            This is optional, however do not specifically set this to an
#            empty string as this will cause the daemon to run with group wheel.
#            Default: jackett
# jackett_data_dir:    Directory where jackett configuration
#            data is stored.
#            Default: /usr/local/jackett



# functions to help installation
. ./functions.sh

_JACKETT_DATA_DIR=/app-data/Sonarr
_JACKETT_USER=media

# install jackett
Install_Package "jackett"

# make jackett the owner of app-data directory
echo =====\> make jackett owner of $_JACKETT_CONFIG_DIR config directory
chown -R jackett:jackett $_JACKETT_DATA_DIR

# NOTE:  FreeNAS installs user "Media" and group "Media when
#        the jail gets created
# pw groupadd 'media' -g '816'
# pw useradd 'media' -u '816' -g 'media'

#chown -R media:media /usr/local/share/sonarr

echo =====\> set jackett data dir to $_JACKETT_DATA_DIR
sysrc "jackett_data_dir=$_JACKETT_DATA_DIR"

#echo =====\> have jackett run as user $_JACKETT_USER
#sysrc "jackett_user=$_JACKETT_USER"

echo =====\> enable jackett to start at boot
sysrc  "jackett_enable=YES"

# no longer needed as we now set sonarr to run as user media
# add sonarr user to media group
#echo =====\> add "sonarr" user to "media" group
#pw groupmod media -m sonarr


