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

# make radarr the owner of program directory
Inform "make radarr the owner of the program directory"
chown -R radarr:radarr /usr/local/share/radarr

# make radarr the owner of app-data directory
Inform "make radarr owner of $_RADARR_DATA_DIR config directory"
chown -R radarr:radarr $_RADARR_DATA_DIR

Inform "set radarr data dir to $_RADARR_DATA_DIR"
sysrc "radarr_data_dir=$_RADARR_DATA_DIR"

Inform "enable radarr start at boot"
sysrc "radarr_enable=YES"

# add radarr user to media group
Inform "add media group to radarr user"
pw groupmod media -m radarr

