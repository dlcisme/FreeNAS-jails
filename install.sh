#!/bin/sh

# title for script
_TITLE=" === JAILS  MAINTENANCE ==="

# prompt for the users choice
_PROMPT="Pick an option:"

# error message for invalid choice
_CHOICE_ERR_MSG="Invalid choice:"

# set the available options here
_OPTIONS="
1. Install Nano
2. Install Stuff
3. Enable SSH
4. Disable SSH
5. Install Nginx
6. Install Sonarr
Q. Quit
"

#======================================================
#                  F U N C T I O N S
#======================================================

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

#-------------------------------------------------------
# install nano
#-------------------------------------------------------
Install_Nano ()
{

  # install the nano package
pkg install -y nano

}

#-------------------------------------------------------
# install nginx
#-------------------------------------------------------
Install_Nginx ()
{

  # install the nginx package
pkg install -y nginx

}

#-------------------------------------------------------
# install sonarr
#-------------------------------------------------------
Install_Sonarr ()
{



}

#-------------------------------------------------------
# do user's choice
#-------------------------------------------------------
Do_User_Choice ()
{
  case $_choice in
     1 ) Install_Nano ;;
     2 ) echo $_choice ;;
     3 ) echo $_choice ;;
     4 ) echo $_choice ;;
     5 ) Install_Nginx ;;
     6 ) Install_Sonarr ;;
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
  echo $_TITLE

  # show the options
  Show_Options

  # get the user's choice
  Get_User_Choice

  # do the user's choice
  Do_User_Choice

done
