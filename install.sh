#!/bin/sh

# title for script
_TITLE=" === JAILS  MAINTENANCE ==="

# prompt for the users choice
_PROMPT="Pick an option:"

# error message for invalid choice
_CHOICE_ERR_MSG="Invalid choice:"

# set the available options here
_OPTIONS="
0. Install Base Packages
1. Install Nginx
2. Install Transmission
3. Install Jackett
4. Install Sonarr
5. Install Radarr
6. Install Plex
7. Install Minecraft
Q. Quit
"

#======================================================
#                  F U N C T I O N S
#======================================================

# functions to help installation
. ./functions.sh

#------------------------------------------------------
# show options to user
#------------------------------------------------------
Show_Options ()
{
    # display each option
  for _option in "$_OPTIONS"
  do
    echo "$_option"
  done
}

#-------------------------------------------------------
# get the user's choice
#-------------------------------------------------------
Get_User_Choice ()
{
    # if there is an error message, display it
  [ "$_Error_Message" ] && echo "$_Error_Message "

    # get the response from the user
  echo -n "$_PROMPT "
  read _choice
}

Install_Choice ()
{

_choice=$1

  # install the users choice
. ./$_choice.sh

}


#-------------------------------------------------------
# do user's choice
#-------------------------------------------------------
Do_User_Choice ()
{
  case $_choice in
     0 ) Install_Choice "base_packages" ;;
     1 ) Install_Choice "nginx" ;;
     2 ) Install_Choice "transmission" ;;
     3 ) Install_Choice "jackett" ;;
     4 ) Install_Choice "sonarr" ;;
     5 ) Install_Choice "radarr" ;;
     6 ) Install_Choice "plex" ;;
     7 ) Install_Choice "minecraft" ;;
   q|Q ) break;;
     * ) _Error_Message="$_CHOICE_ERR_MSG $_choice" ;;
  esac
}

#=======================================================
#                M A I N   P R O G R A M
#=======================================================

# do forever
while true
do
  
  # display the scripts title
  echo; echo $_TITLE

  # show the options
  Show_Options

  # get the user's choice
  Get_User_Choice

  # do the user's choice
  Do_User_Choice

done
