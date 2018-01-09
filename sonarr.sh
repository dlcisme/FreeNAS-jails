#!/bin/sh

# functions to help installation
. ./functions.sh

_SONARR_DATA_DIR=/var/local/sonarr
_SONARR_USER=media

# install sonarr
Install_Package "sonarr"

# NOTE:  FreeNAS installs user "Media" and group "Media when
#        the jail gets created
# pw groupadd 'media' -g '816'
# pw useradd 'media' -u '816' -g 'media'

#chown -R media:media /usr/local/share/sonarr

echo =====\> set sonarr data dir to $_SONARR_DATA_DIR
sysrc "sonar_data_dir=$_SONARR_DATA_DIR"

echo =====\> have sonarr run as user $_SONARR_USER
sysrc "sonarr_user=$_SONARR_USER"

echo =====\> enable sonarr to start at boot
sysrc  "sonarr_enable=YES"

# no longer needed as we now set sonarr to run as user media
# add sonarr user to media group
#echo =====\> add "sonarr" user to "media" group
#pw groupmod media -m sonarr


# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# sonarr_enable (bool): Set to NO by default.
#                       Set it to YES to enable it.
# sonarr_data_dir:      Directory where sonarr configuration
#                       data is stored.
#                       Default: /home/${sonarr_user}/.config/NzbDrone
# sonarr_user:  The user account sonarr daemon runs as what
#                       you want it to be. It uses '%%USER%%' user by
#                       default. Do not sets it as empty or it will run
#                       as root.
# sonarr_group: The group account sonarr daemon runs as what
#                       you want it to be. It uses '%%GROUP%%' group by
#                       default. Do not sets it as empty or it will run
#                       as wheel.