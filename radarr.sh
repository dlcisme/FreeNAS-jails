#!/bin/sh


# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# radarr_enable (bool): Set to NO by default.
#                       Set it to YES to enable it.
# radarr_data_dir:      Directory where radarr configuration
#                       data is stored.
#                       Default: /home/${radarr_user}/.config/NzbDrone
# radarr_user:  The user account radarr daemon runs as what
#                       you want it to be. It uses '%%USER%%' user by
#                       default. Do not sets it as empty or it will run
#                       as root.
# radarr_group: The group account radarr daemon runs as what
#                       you want it to be. It uses '%%GROUP%%' group by
#                       default. Do not sets it as empty or it will run
#                       as wheel.

_RADARR_DATA_DIR=/app-data/Radarr

# functions to help installation
. ./functions.sh

# install radarr
Install_Package "radarr"

# make radarr the owner of app-data directory
echo =====\> make radarr owner of $_RADARR_CONFIG_DIR config directory
chown -R radarr:radarr $_RADARR_DATA_DIR

# NOTE:  FreeNAS installs user "Media" and group "Media when
#        the jail gets created
# pw groupadd 'media' -g '816'
# pw useradd 'media' -u '816' -g 'media'

#chown -R media:media /usr/local/share/radarr

echo =====\> enable radarr start at boot
sysrc "radarr_enable=YES"

# add radarr user to media group
echo =====\> add "radarr" user to "media" group
pw groupmod media -m radarr

