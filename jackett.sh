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


_JACKETT_DATA_DIR=/app-data/Jackett



# functions to help installation
. ./functions.sh

# install jackett
Install_Package "jackett"

# make jackett the owner of app-data directory
Inform "make jackett owner of $_JACKETT_CONFIG_DIR config directory"
chown -R jackett:jackett $_JACKETT_DATA_DIR

# set data directory for jackett
Inform "set jackett data dir to $_JACKETT_DATA_DIR"
sysrc "jackett_data_dir=$_JACKETT_DATA_DIR"

# enable jackett to start at boot
Inform "enable jackett to start at boot"
sysrc  "jackett_enable=YES"

