macOS Cheatsheet

show hidden files in finder
defaults write com.apple.Finder AppleShowAllFiles true

remove_disk: spin down unneeded disk

diskutil eject /dev/disk1s3
to change the password on an encrypted disk image:

hdiutil chpass /path/to/the/diskimage
to mount a read-only disk image as read-write:
hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify
mounting a removable drive (of type msdos or hfs)

mkdir /Volumes/Foo
ls /dev/disk*   to find out the device to use in the mount command)
mount -t msdos /dev/disk1s1 /Volumes/Foo
mount -t hfs /dev/disk1s1 /Volumes/Foo

to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
