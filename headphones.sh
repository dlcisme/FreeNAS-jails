#!/bin/sh

pkg update
pkg upgrade

pkg install py27-sqlite3
pkg27-cheetah

pkg delete -f sqlite3
fetch "http://pkg.freebsd.org/freebsd:11:x86:64/release_0/All/sqlite3-3.13.0.txz"
pkg add sqlite3-*.txz



ln -s /usr/local/bin/python2.7 /usr/local/bin/python

git clone https://github.com/rembo10/headphones.git /usr/local/share/headphones
pw user add headphones -c headphones -u 110 -d /nonexistent -s /usr/bin/nologin
chown -R headphones:headphones /usr/local/share/headphones /app-data/headphones
cp /usr/local/share/headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
chmod u+x /usr/local/etc/rc.d/headphones
sysrc "headphones_enable=YES"
sysrc "headphones_user=headphones"
sysrc "headphones_dir=/usr/local/share/headphones"
sysrc "headphones_conf=/app-data/headphones/config.ini"
sysrc "headphones_flags=--datadir /app-data/headphones --host=0.0.0.0"
sed -i '' -e 's?/var/run/headphones/headphones.pid?/app-data/headphones/headphones.pid?g' /usr/local/etc/rc.d/headphones
service headphones start
