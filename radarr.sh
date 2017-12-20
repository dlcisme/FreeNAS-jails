#!/bin/sh

# installation script for radarr in a FreeNAS jail

# code borrowed from:
# https://github.com/Radarr/Radarr/wiki/Installation
# check if running into errors as it offers hints
# NOTE: github has another package being installed
#       which is not installed here


# you may want to grab the latest release URL, however,
# you can just update Radarr from its web UI once
# installed
VERSION="0.2.0.870"

# directory where Radarr will be installed
RADARR_DIR="/usr/local/share"

# update any installed packages
echo
echo updating packages
pkg update

# upgrade any installed packages
echo
echo upgrading packages
pkg upgrade -y



#======================================================
#                  F U N C T I O N S
#======================================================

# functions to help installation
. ./functions.sh


#------------------------------------------------------
# install the required packages
#------------------------------------------------------
Install_Required_Packages ()
{

  # Install the required packages

  Install_Package "mono"
  Install_Package "mediainfo"
  Install_Package "sqlite3"

}

#------------------------------------------------------
# install Radarr
#------------------------------------------------------
Install_Radarr ()
{

  echo
  echo fetch Radarr
  fetch https://github.com/Radarr/Radarr/releases/download/v"$VERSION"/Radarr.develop."$VERSION".linux.tar.gz

  echo
  echo Put Radarr in $RADARR_DIR
  tar -xzvf Radarr.*.linux.tar.gz -C $RADARR_DIR

  echo
  echo cleanup Radarr files
  rm Radarr.*.linux.tar.gz

}




#=======================================================
#                M A I N   P R O G R A M
#=======================================================

# Install the required packages
Install_Required_Packages

# link mono to /usr/bin/mono so Radarr can update
# properly on its own with its built in functionality
ln -s /usr/local/bin/mono /usr/bin/mono

# Install Radarr
Install_Radarr
