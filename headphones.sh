#!/bin/sh

ln -s /usr/local/bin/python2.7 /usr/local/bin/python

git clone https://github.com/rembo10/headphones.git /usr/local/share/headphones
pw user add headphones -c headphones -u 110 -d /nonexistent -s /usr/bin/nologin
chown -R headphones:headphones /usr/local/share/headphones /app-data/headphones
cp /usr/local/share/headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
chmod u+x /usr/local/etc/rc.d/headphones
sysrc "headphones_enable=YES"
sysrc "headphones_user=headphones"
sysrc "headphones_dir=/usr/local/share/headphones"
headphones sysrc "headphones_conf=/app-data/config.ini"
sysrc "headphones_flags=--datadir /config --host=0.0.0.0"
sed -i '' -e 's?/var/run/headphones/headphones.pid?/config/headphones.pid?g' /usr/local/etc/rc.d/headphones
service headphones start
