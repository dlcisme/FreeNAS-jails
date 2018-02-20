#!/bin/sh

# NOTE: use uname -KU to get version number

# pull down latest package from FreeBSD repos even if its already present
/usr/sbin/pkg-static bootstrap -f
# force updating the newly bootstrapped package DB from FreeBSD again
/usr/local/bin/pkg -o OSVERSION=1101505 update -r FreeBSD -f
# and now we should be able to upgrade as usual
/usr/local/bin/pkg -o OSVERSION=1101505 upgrade -r FreeBSD
