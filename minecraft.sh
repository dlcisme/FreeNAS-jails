#!/bin/sh

# code borrowed from:
# https://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(pkg_add)
# check here for most up to date procedures.


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

  # not required, but some Minecraft mods require them
  Install_Package "bash"
  Install_Package "wget"

}


#------------------------------------------------------
# install MineOS
#------------------------------------------------------
Install_MineOS ()
{

  echo; echo =====\> create directory /usr/local/compat/linux/proc
  mkdir -p /usr/local/compat/linux/proc

  echo; echo =====\> create directory $GAMES_DIR
  mkdir -p $GAMES_DIR

  echo; echo =====\> get MineOS from github
  git clone git://github.com/hexparrot/mineos-node $MINECRAFT_DIR

  echo; echo =====\> grant execute permission to files
  chmod +x $MINECRAFT_DIR/service.js
  chmod +x $MINECRAFT_DIR/mineos_console.js
  chmod +x $MINECRAFT_DIR/webui.js
  chmod +x $MINECRAFT_DIR/generate-sslcert.sh

  echo; echo =====\> generate ssl certificate
  $MINECRAFT_DIR/generate-sslcert.sh

  echo; echo =====\> copy configuation file to system location
  cp $MINECRAFT_DIR/mineos.conf /etc/mineos.conf

  echo; echo =====\> create NPM modules
  echo "cd/ $MINECRAFT_DIR/; CXX=c++ npm install" | sh

}


#------------------------------------------------------
# start web-ui at boot
#------------------------------------------------------
Start_web-ui ()
{

  # Start the web ui at boot time

  echo; echo =====\> copy web-ui configuration file to system location 
  cat $MINECRAFT_DIR/init/supervisor_conf.bsd >> /usr/local/etc/supervisord.conf

  echo; echo =====\> enable web-ui deamon at start up
  sysrc supervisord_enable="YES"

}


#------------------------------------------------------
# add user
#------------------------------------------------------
Add_user ()
{

  # add the unprivileged mcserver user

  echo; echo =====\> add MCSERVER user
  echo mcserver | pw user add -n mcserver -s /bin/bash -m -h 0 -c "User for MineOS" -G games

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

# Add mcserrver user
#Add_user