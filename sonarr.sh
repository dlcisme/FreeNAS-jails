#!/bin/sh

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


# functions to help installation
. ./functions.sh

_SONARR_DATA_DIR=/app-data/Sonarr

# install sonarr
Install_Package "sonarr"

# make sonarr the owner of program directory
Inform "make sonarr the owner of the program directory"
chown -R sonarr:sonarr /usr/local/share/sonarr

# make sonarr the owner of app-data directory
Inform "make sonarr owner of $_SONARR_DATA_DIR config directory"
chown -R sonarr:sonarr $_SONARR_DATA_DIR

Inform "set sonarr data dir to $_SONARR_DATA_DIR"
sysrc "sonarr_data_dir=$_SONARR_DATA_DIR"

Inform "enable sonarr to start at boot"
sysrc  "sonarr_enable=YES"

Inform "add media group to sonarr user"
pw groupmod media -m sonarr


