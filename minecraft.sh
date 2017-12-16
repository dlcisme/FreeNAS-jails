#!/bin/sh

# code borrowed from:
# https://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(pkg_add)

# something about boot loader..."linprocfs"... I think freenas already does this



GAMES_DIR="/usr/local/games"
MINECRAFT_DIR="$GAMES_DIR/minecraft"



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

  Install_Package "rdiff-backup"
  Install_Package "rsync"
  Install_Package "gmake"
  Install_Package "screen"
  Install_Package "git"
  Install_Package "sysutils/py-supervisor"
  Install_Package "node"
  Install_Package "npm4"
  Install_Package "openjdk8-jre"

}


#------------------------------------------------------
# install MineOS
#------------------------------------------------------
Install_MineOS ()
{

  echo
  echo create directory /usr/local/games
  mkdir -p /usr/local/games

  echo
  echo get MineOS from github
  git clone git://github.com/hexparrot/mineos-node /usr/local/games/minecraft

  echo
  echo grant execute permission to files
  chmod +x $MINECRAFT_DIR/service.js
  chmod +x $MINECRAFT_DIR/mineos_console.js
  chmod +x $MINECRAFT_DIR/webui.js
  chmod +x $MINECRAFT_DIR/generate-sslcert.sh

  echo
  echo generate ssl certificate
  $MINECRAFT_DIR/generate-sslcert.sh

  echo
  echo copy configuation file to system location
  cp $MINECRAFT_DIR/mineos.conf /etc/mineos.conf

  echo
  echo create NPM modules
  echo "CXX=c++ npm install" | sh

}


#------------------------------------------------------
# start web-ui at boot
#------------------------------------------------------
Start_web-ui ()
{

  # Start the web ui at boot time

  echo
  echo copy web-ui configuration file to system location 
  cat $MINECRAFT_DIR/init/supervisor_conf.bsd >> /usr/local/etc/supervisord.conf

  echo
  echo enable web-ui deamon at start up
  sysrc supervisord_enable="YES"

}



#=======================================================
#                M A I N   P R O G R A M
#=======================================================

# Install the required packages
Install_Required_Packages

# Install MineOS
Install_MineOS

# Start the web-ui at boot time
Start_web-ui
