#!/bin/sh

#------------------------------------------------------
# install the package, display what package is being
# installed
#------------------------------------------------------
Install_Package ()
{

    # get the package to install from parm $1
  _package="$1"

    # display the package being installed
  Inform "=====\> Installing: $_package"

    # install the package
  pkg install -y "$_package"

}

#------------------------------------------------------
# display a message on the screen, inform the user
# what's happening
#------------------------------------------------------
Inform ()
{

    # get the message to display
  _message="$1"

    # display the message to the screen
  echo; echo =====\> "$_message"

}
