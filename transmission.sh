#!/bin/sh

# functions to help installation
. ./functions.sh

# install transmission
Install_Package "transmission"

# enable transmission to start at boot
echo =====\> enable transmission to start at boot
sysrc "transmission_enable=YES"



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


