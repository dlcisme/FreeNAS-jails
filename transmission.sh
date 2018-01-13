#!/bin/sh

_TRANSMISSION_CONFIG_DIR=/app-data/Transmission
_TRANSMISSION_DOWNLOAD_DIR=/app-data/Transmission/Downloads



# Add the following lines to /etc/rc.conf to enable this service:
#
# transmission_enable:	     Set to NO by default. Set it to YES to enable it.
# transmission_watch_dir:    Directory for torrent files to download
#			     automatically. Off by default unless you add
#			     a path.
# transmission_conf_dir:     Directory where transmission configuration
#			     data is stored.
#			     Default: /usr/local/etc/transmission/home
# transmission_download_dir: Directory to store downloaded data.
#			     Default: /usr/local/etc/transmission/home/Downloads
# transmission_user:	     The user account transmission daemon runs as what
#			     you want it to be. It uses 'transmission' user by
#			     default.
# transmission_web_home:     Use alternative directory for the web interface
#			     files, such as javascript, html and graphics.
# transmission_chown:	     By default, transmission checks and fixes the
#			     permissions for its home directory.  If this
#			     causes problems, set this variable to no.

# functions to help installation
. ./functions.sh

# install transmission
Install_Package "transmission"

# make transmission the owner of Transmission config directory
echo =====\> make transmission owner of $_TRANSMISSION_CONFIG_DIR config directory
chown -R transmission:transmission $_TRANSMISSION_CONFIG_DIR

# enable transmission to start at boot
echo =====\> enable transmission to start at boot
sysrc "transmission_enable=YES"

# directory for transmission configuration files
echo =====\> set directory for transmission configuation files
sysrc "transmission_conf_dir=$_TRANSMISSION_CONFIG_DIR"

# directory for transmission download files
echo =====\> set directory for transmission download files
sysrc "transmission_download_dir=$_TRANSMISSION_DOWNLOAD_DIR"
