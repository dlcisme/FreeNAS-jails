#!/bin/sh


# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# headphones_enable (bool): Set to NO by default.
#           Set it to YES to enable it.
# headphones_user:  The user account Headphones daemon runs as what
#           you want it to be. It uses '_sabnzbd' user by
#           default. Do not sets it as empty or it will run
#           as root.
# headphones_dir:   Directory where Headphones lives.
#           Default: /usr/local/headphones
# headphones_pid:  The name of the pidfile to create.
#     Default is headphones.pid in headphones_dir.



# maybe make new function "hint"/"clue"/tip"advise"notify"report/tell/write/inform 
# to display messages to user

# functions to help installation
. ./functions.sh

# upadate everything first
pkg update
pkg upgrade

# install the required packages
Install_Package "py27-sqlite3"
Install_Package "pkg27-cheetah"

# This is needed until FreeNAS changes their jails to be built on FreeBSD 11.1
# There is a bug when packages built on FreeBSD 11.1 are installed on FreeBSD 11.0
# https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=221672
# The following will fix the bug
#---------------------------------------------------------------------------------
pkg delete -f sqlite3
fetch "http://pkg.freebsd.org/freebsd:11:x86:64/release_0/All/sqlite3-3.13.0.txz"
pkg add sqlite3-*.txz
rm sqlite3-3.13.0.txz
#---------------------------------------------------------------------------------


# test ... is this needed
echo; echo =====\> is this still needed?? test
ln -s /usr/local/bin/python2.7 /usr/local/bin/python

echo; echo =====\> get Headphones from git
git clone https://github.com/rembo10/headphones.git /usr/local/share/headphones

echo; echo =====\> create headphones user
pw user add headphones -c headphones -u 110 -d /nonexistent -s /usr/bin/nologin

echo; echo =====\> make headphones owner of program and data
chown -R headphones:headphones /usr/local/share/headphones /app-data/headphones

echo; echo =====\> copy rc script to system location
cp /usr/local/share/headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones

echo; echo =====\> grant execution to files
chmod u+x /usr/local/etc/rc.d/headphones

echo; echo =====\> enable headphones at start up
sysrc "headphones_enable=YES"

echo; echo =====\> make headphones the user of program
sysrc "headphones_user=headphones"

echo; echo =====\> set headphones program directory
sysrc "headphones_dir=/usr/local/share/headphones"

echo;echo =====\> set headphones data directory
sysrc "headphones_conf=/app-data/headphones/config.ini"

echo; echo =====\> set headphones program flags
sysrc "headphones_flags=--datadir /app-data/headphones --host=0.0.0.0"

echo; echo not sure what this does
sed -i '' -e 's?/var/run/headphones/headphones.pid?/app-data/headphones/headphones.pid?g' /usr/local/etc/rc.d/headphones

echo; echo starting headphones
service headphones start
