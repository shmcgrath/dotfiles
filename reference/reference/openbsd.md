# OpenBSD

mouse configs in /etc/wsconsctl.conf

ixenodm settings removing console on startup
/etc/X11/xenodm/Xsetup_0

Intel conf

/etc/X11/xorg.conf.d/intel.conf
Section "Device"
  Identifier "drm"
  Driver "intel"
  Option "TearFree" "true"
EndSection

Get rid of google:
Configure timekeeping facilities
https://www.ntppool.org/zone/north-america

The Network Time Procotol can be used to automatically update the clock on your machine. This is a convenient way to ensure your clock stays in sync and won't drift over time. First, add the following line in /etc/rc.conf.local to force ntpd (the NTP daemon) to synchronize the clock immediately on startup.

ntpd_flags="-s"

Next, visit the NTP Pool Project site to identify NTP servers nearest to you. On the right-hand side you should see a breakdown by continent, through which you can drill down to specific server pools. Your country may even have dedicated pools. With this information you can fill in the /etc/ntpd.conf file to control how ntpd gets updates. Using the "servers" (plural) and "constraints" (plural) keywords ensures that if the URL resolves to multiple IP addresses, they will all be checked. Don't forget the 's'.

listen on *

servers 0.us.pool.ntp.org
servers 1.us.pool.ntp.org
servers 2.us.pool.ntp.org
servers 3.us.pool.ntp.org

constraints from "https://www.iso.org"
constraints from "https://www.nist.gov"

The constraints URLs are used as a sanity-check on the values received from your NTP pools to protect against a man-in-the-middle attack attempting to sabotage your systems clock. You may choose any HTTPS sites you wish, but a couple standards organizations and popular sites should do you well. Don't forget to enclose these constraints URLs in quotes, otherwise ntpd will yell at you.

vim /etc/rc/conf.local

# boot to graphic console absolute open bsd p. 67
# enable ntpd absolute open bsd p. 61
# enable power management c0ffee.net

apmd_flags=-A
ntpd_flags="-s"
xdm_flags=""
xenodm_flags=
Since this is a laptop, you'll probably want your screen to lock automatically when you close the lid. You can configure apmd to do this for you. (Note that this won't be effective until we configure X11 in the section below.)

First, make the directory:

mkdir /etc/apm

Then, create the file /etc/apm/suspend with the following contents:

/etc/apm/suspend
#!/bin/sh
pkill -USR1 xidle

And make it executable:

chmod +x /etc/apm/suspend
