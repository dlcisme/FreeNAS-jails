# FreeNAS-jails
Scripts to install software in jails

Note: Parametes for start up scripts are kept in (program name).in.  Use "find / -name (program name).in" to find the location of the file to get the start up script parameters to set in /etc/rc.conf file.

Todo:  When creating jails

```
Jail name: media_jail
IPv4 address: 192.168.1.3/24
autostart: checked
type: pluginjail
VIMAGE: unchecked
vanilla: checked
sysctls: allow.raw_sockets=true,allow.sysvipc=true

# allow service to run under ports 1024
sysctl net.inet.ip.portrange.reservedhigh=0
```

MineOS
/etc/mineos.conf -> config file, can change port and ssl here


Plex
/app-data/Plex/Plex Media Server/Preferences.xlm -> advanced hidden server settings



