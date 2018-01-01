#!/bin/sh

# functions to help install packages
. ./functions.sh

# install "nginx" package
Install_Package "nginx"

# enable nginx to start at boot
echo =====\> enable nginx to start at boot
sysrc "nginx_enable=YES"

