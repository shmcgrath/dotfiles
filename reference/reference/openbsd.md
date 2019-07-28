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
