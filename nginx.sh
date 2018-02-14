#!/bin/sh

_NGINX_DATA_DIR=/app-data/Nginx


#
# Add the following lines to /etc/rc.conf to enable nginx:
# nginx_enable (bool):          Set to "NO" by default.
#                               Set it to "YES" to enable nginx
# nginx_profiles (str):         Set to "" by default.
#                               Define your profiles here.
# nginx_pid_prefix (str):       Set to "" by default.
#                               When using profiles manually assign value to "n$
#                               for prevent collision with other PIDs names.
# nginxlimits_enable (bool):    Set to "NO" by default.
#                               Set it to yes to run `limits $limits_args`
#                               just before nginx starts.
# nginx_flags (str):            Set to "" by default.
#                               Extra flags passed to start command.
# nginxlimits_args (str):       Default to "-e -U %%WWWOWN%%"
#                               Arguments of pre-start limits run.


# functions to help install packages
. ./functions.sh

# install "nginx" package
Install_Package "nginx"

# make nginx the owner of Nginx config directory
Inform "make nginx owner of $_NGINX_DATA_DIR config directory"
chown -R nginx:nginx $_NGINX_DATA_DIR

# enable nginx to start at boot
Inform "enable nginx to start at boot"
sysrc "nginx_enable=YES"

# set Nginx config file and data directory location
Inform "set Nginx config file and data directory location"
sysrc "nginx_flags=-c $_NGINX_DATA_DIR/nginx.conf -p $_NGINX_DATA_DIR"
