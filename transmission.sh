#!/bin/sh

# functions to help installation
. ./functions.sh

# install transmission
Install_Package "transmission"

# enable transmission to start at boot
echo =====\> enable transmission to start at boot
sysrc "transmission_enable=YES"
