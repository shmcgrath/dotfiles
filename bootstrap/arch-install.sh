#!/usr/bin/env bash


printf "%s\n" "verifying boot mode..."
FW_FILE="/sys/firmware/efi/fw_platform_size"

if [[ -f "$FW_FILE" ]]; then
    size=$(<"$FW_FILE")
    case "$size" in
        64)
            printf "System booted in UEFI mode with 64-bit x64 UEFI.\n";;
        32)
            printf "System booted in UEFI mode with 32-bit IA32 UEFI.\n";;
        *)
            printf "System booted in UEFI mode with unknown width: %s\n" "$size";;
    esac
else
    printf "No %s file found: system may be booted in BIOS (or CSM) mode. Refere to motherboard's manual.\n" "$FW_FILE"
fi

ip link
networkctl list
iwctl # check the other notes for this
# systed-networkd and systemd-resolved
ping ping.archlinux.org
timedatectl
lsblk -dno NAME,SIZE,MODEL
fdisk -l
# cfdisk /dev/XXX
# /boot
# swap
# /
# /home
mkfs.ext4 /dev/root_partition
mkswap /dev/swap_partition
mkfs.fat -F 32 /dev/efi_system_partition
mount --mkdir /dev/root_partition /mnt
mount --mkdir /dev/efi_system_partition /mnt/boot
mount --mkdir /dev/home_partition /mnt/home
mount --mkdir /dev/games /mnt/home/shmcg/games
swapon /dev/swap_parition
reflector --save /etc/pacman.d/mirrorlist --protocol https --country US --fastest 25 --sort rate --threads 4
export EDITOR=nvim
pacstrap -K /mnt base linux linux-firmware linux-headers base-devel iwd grub efibootmgr neovim git bash man-pages man-db kanshi keychain keepassxc less stow tealdeer texinfo tmux opendoas openssh reflector pacman-contrib
# check if i have anything running in cron and move it to systemd for now? i dont think im going to do void or gentoo

# make sure to uncomment lib32
# other explicit installs from old one
# pacman -S alsa-utils

# if amd cpu
# pacman -S amd-ucode

# if amd graphics
# pacman -S amdgpu_top
# desktop environment wayland
# pacman -S sway wezterm dunst ghostty fuzzel swaybg swayidle swaylock waybar
# other utils
# pacman -S 7zip bat docker docker-compose fd glow fzf eza gpick grim gtk2fontsel gzip htop lazygit lf qmk rclone rsync rtorrent satty smartmontools thunar trash-cli vifm vimiv imv w3m wev wget wl-clipboard xclip xsel zoxide zip xterm zbar picocom mediainfo navi
# imv vs vimiv - set up vifm with that - check the script that is installed - sixel
# lf image preview and zip file preview
# programs
# pacman -S calibre darktable digikam discord gimp qalculate-gtk tiny zathura zathura-pdf-mupdf libreoffice-fresh obsidian
# fonts
# pacman -S bdf-unifont ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols <-- FIND WHCIH OF THE ONES YOU WANT AND WHAT WAS EXPLICITLY INSTALLED WAS MONO noto-fonts-emoji
# browsers
# pacman -S chromium firefox firefox-developer-edition
# aur
# cryptomator cryptomator-cli dropbox dropbox-cli lswt thunar-dropbox wowup-cf-bin youtube-dl yay pandoc-bin
# programming lanugage and tools
# pacman -S go
# not sure i need tools: sassc
# gaming
# pacman -S jre21-openjdk lutris prismlauncher steam wine wine-mono wine-gecko winetricks gamemode lib32-gamemode vulkan-radeon vulkan-tools lib32-vulkan-intel (not sure if need last one?)
# x11
# pacman -S slock sxhkd
# x11 tools
# pacman -S 

# not going to install?
# arch-wiki-docs: replaced by local install and customization?
# bat-extras emacs
#
# not sure if need?
# autoconf automake bind binutils bison blueprint-compiler cadaver clang ddcutil gjs keepass-plugin-keeagent wpa_supplicant zbar zig papirus-icon-theme
# set up i3wm using most of sway config?
# pick a music player: https://old.reddit.com/r/archlinux/comments/cjn3f7/what_music_player_do_you_use_and_why/
# cmus
# thunderbird or calcurse abook and mutt khard and khal
# https://itsfoss.com/calcurse/
# osmo

printf "%s\n" "Generating fstab and opening in $EDITOR..."
genfstab -U /mnt >> /mnt/etc/fstab
$EDITOR /mnt/etc/fstab
arch-chroot /mnt
export EDITOR=nvim
export PS1="(ch) $PS1"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
timedatectl show-timesync --all
systemd enable --now systemd-timesyncd.service
networkctl list
$EDITOR /etc/locale.gen
printf "%s\n" "uncomment the UTF-8 locales you will be using"
locale-gen
$EDITOR /etc/locale.conf
printf "%s\n" "For advice on choosing a hostname, see RFC 1178. As explained in hostname(7), it must contain from 1 to 63 characters, using only lowercase a to z, 0 to 9, and -, and must not start with -."
$EDITOR /etc/hostname
printf "%s\n" "change root password"
passwd
# https://wiki.archlinux.org/title/General_recommendations
printf "%s\n" "install bootloader"
# https://github.com/vinceliuice/Grub2-themes
printf "%s\n" "set up user in wheel and ssh"
printf "%s\n" "set up ssh users"
printf "%s\n" "exiting chroot environment"
exit
printf "%s\n" "rebooting... remove installation medium"
