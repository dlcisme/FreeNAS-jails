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
  echo; echo Installing: "$_package"

    # install the package
  pkg install -y "$_package"

}

