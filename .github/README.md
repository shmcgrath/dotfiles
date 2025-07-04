# Dotfiles

This is a collection of my dotfiles. I am just starting to build them up in March of 2017. I am currently running an [Arch Linux](https://www.archlinux.org/) pseudo-server and am using an Apple laptop.

I will update this README with more links, tips, and information as I grow my dotfiles.

## Submodules

This repo has [vim-infolines](https://github.com/shmcgrath/vim-infolines) as a submodule. After cloning a repo with a submodule, the submodules need to be initialized and updated.

``` bash
git clone --recursive https://github.com/username/repo.git
```

If the repo containing submodules has already been cloned, update them.

``` bash
git submodule update --init --recursive
```

Command to update a submodule:
``` bash
git submodule update --remote
```

## Dotfile Management with GNU Stow and GitHub

I use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage my dotfiles. This allows me to easily create symlinks on any \*nix-based system I am using. I chose Stow because it is easily and universally available on \*nix machines. I do use Windows boxes, but I don't see myself needing the majority of my dotfiles on those machines. One tool I found when looking for Windows alternatives is [stow-lite](https://github.com/ericsubach/stow-lite) but I have not used it yet. I also chose stow because I would be able to use it to manage config files that are not in ~/. In the future, I can use stow to deploy centralized config files across my system(s). 
 
### GNU Stow and .DS\_Store Files

I ran into a bit of an issue when creating the symlinks on Sierra. I kept getting an error message referencing .DS\_Store files. After some Googling, I found that if you run Stow with an --ignore flag for .DS\_Store, that error will not pop.

``` bash
$ stow -v --ignore ".DS_Store" -t ~/ folder

```

You can also create a [.stow-global-ignore file](https://www.gnu.org/software/stow/manual/stow.html#Ignore-Lists) in your home directory and add .DS_Store to that file.


When stowing grub, run as sudo with -Rv flags and --target of /

``` bash
$ sudo stow -Rv -t / grub

```

## Useful Links for Dotfile Management and Creation
These are some of the links that I found useful when figuring out how to manage dotfiles and when setting up the programs they configure.

### Dotfiles
- [Arch Linux Wiki on dotfiles](https://wiki.archlinux.org/index.php/Dotfiles)
- [GitHub Dotfiles](https://dotfiles.github.io/)
- [Hacker News - Using GNU Stow to manage your dotfiles](https://news.ycombinator.com/item?id=8487840)
- [Hacker News - What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)
- [Hacker News - Managing dotfiles with GNU Stow](https://news.ycombinator.com/item?id=11515222)

### [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)
- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [Managing Dotfiles with GNU Stow](https://taihen.org/managing-dotfiles-with-gnu-stow/)
- [Stow Your Dotfiles - GNW Stow for Managing Symlinks](https://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/)
- [Stow](http://onethingwell.org/post/39744163899/stow-your-dotfiles)
- [Using GNU Stow to Manage Your Dotfiles](http://www.kianmeng.org/2014/03/using-gnu-stow-to-manage-your-dotfiles.html)

### Bash
- [Nathaniel Landau's Bash Profile Gist](https://gist.github.com/natelandau/10654137/)

### [Vim](http://www.vim.org/)
- [A Good Vimrc](https://dougblack.io/words/a-good-vimrc.html)
- [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com)
- [Best of My Vimrc](http://sts10.github.io/blog/2016/02/12/best-of-my-vimrc/)

## My Config Notes:
- Current iTerm colorscheme: base16 tomorrownight dark 256
- When bootstraping a new machine, change the $HOME in .stowrc to the actual home path of the machine
- Make sure to mark stowrc and newsblur-pass as [assume-unchnaged](https://www.git-scm.com/docs/git-update-index)
- Add .scripts to the windows path
- Link to the [vim desert theme](https://github.com/vim/colorschemes/blob/64b7b26ac5571f39cc00215a65a01379fb70ebd3/colortemplate/desert.colortemplate)
- [Materia GTK Theme](https://github.com/nana-4/materia-theme)
- [Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme#extras)

## neovim setup
- I am using [paq-nvim](https://github.com/savq/paq-nvim) as a plugin manager on neovim. I tried lazy.vim, but was unable to get it to work with the pack folder from vim-base.

## Fonts to Install
Install the following fonts:
- gnu-free-fonts
- ttf-liberation
- adobe-source-code-pro-fonts
- noto-fonts-emoji
- ttf-noto-nerd
- ttf-nerd-fonts-symbols
- ttf-nerd-fonts-symbols-common
- ttf-nerd-fonts-symbols-mono
- NerdFont in Repo
- to "install" nerd font from repo, stow it then "fc-cache -f -v"
- gtk font picker: gtk2fontsel
- other gtk settings: lxappearance
- ttf-0xproto-nerd
- otf-commit-mono-nerd
- ttf-meslo-nerd (use MesloLGS Nerd Font Mono)
- for other systems download fonts from [nerdfonts.com](https://www.nerdfonts.com/)

### How to choose a nerd font?
- Pick your font family:
    - If you are limited to monospaced fonts (because of your terminal, etc) then pick a font with Nerd Font Mono (or NFM).
    - If you want to have bigger icons (usually around 1.5 normal letters wide) pick a font without Mono i.e. Nerd Font (or NF). Most terminals support this, but ymmv.
    - If you work in a proportional context (GUI elements or edit a presentation etc) pick a font with Nerd Font Propo (or NFP).
[This information is from the FiraCode section at this GitHub](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode#tldr)
## Colors and Themes
- Baskerville El Dorado Dark
- [cyberdream](https://github.com/scottmckendry/cyberdream.nvim)
- [modus themes](https://github.com/miikanissi/modus-themes.nvim)

## User Scripts (Greasemonkey and Violentmonkey)
- Currently using Violentmonkey
- Installed Scripts:
    - [RSS+Atom Feed Subscribe Button Generator](https://greasyfork.org/en/scripts/6261-rss-atom-feed-subscribe-button-generator/code)
    - [URL Shortener Unshortener](https://greasyfork.org/en/scripts/5359-url-shortener-unshortener)
    - Force Dark Mode
    - old reddit
## macOS system tweaks from terminal
- [This article by Paweł Grzybek](https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/) showed me how to find tweaks I want to set via CLI.

- [macos-defaults.com](https://macos-defaults.com/) lists out commands and values

### Reference Dotfiles for macOS defaults
- mathiasbynens](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
## Installed Packages
### offical repo
- wezterm: terminal
- ghostty
- alacritty
- libqalculate: cli and gui(?) calculator
- zola: static site generator
- keepassxc
- dunst: notificaitons (mako alternative)
- alsa-utils
- htop
- btop
- calibre
- docker
- docker-compose

#### GUI
- xfce
- Hyprland

#### photography
- digikam
- darktable

#### social
- discord

#### xorg

### aur packages
- aurutils
- ladybird
- dropbox


- base linux linux-firmware base-devel dosfstools exfatprogs f2fs-tools e2fsprogs ntfs-3g reflector stow qtile xorg xorg-init rofi firefox kitty uxrvt keepassxc man-db man-pages texinfo less sudo
```
libqalculate
zola
wezterm
ghostty
```
base 3-2
cadaver 0.26-1
calcurse 4.8.1-2
cliphist 1:0.6.1-1
cmus (try mpd and ncmpcpp)
dart-sass 1.83.4-1
eza 0.20.24-1
fbida 2.14-6
fcron 3.3.1-2
feh 3.10.3-1
firefox 136.0.3-1
firefox-developer-edition 137.0b10-1
flameshot 12.1.0-6
fuzzel 1.11.1-2
ghostty 1.1.3-1
gimp 3.0.2-2
glow 2.1.0-1
gobject-introspection 1.84.0-1
gptfdisk 1.0.10-1
grub 2:2.12.r226.g56ccc5ed-1
gtk2fontsel 0.1-8
gucharmap 15.1.1-1
hexchat 2.16.2-4
hexyl 0.16.0-1
htop 3.4.0-1
hyprland 0.48.0-1
imv 4.5.0-5
incron 0.5.12-6
inetutils 2.5-1
isync 1.5.0-2
kdiff3 1.12.2-1
keepass-plugin-keeagent 0.12.1-4
keychain 2.8.5-3
khal 0.11.3-5
ksh 2020.0.0-3
libsixel 1.10.5-1
lxappearance-gtk3 0.6.4-1
man-pages 6.13-1
materia-gtk-theme 20210322-3
mediainfo 25.03-1
meld 3.22.3-1
msmtp 1.8.28-1
neomutt 20250113-1
newsboat 2.39-1
notmuch 0.38.3-5
nsxiv 33-1
obsidian 1.8.9-2
opendoas 6.8.2-3
otf-commit-mono-nerd 3.3.0-1
pacman-contrib 1.11.0-1
papirus-icon-theme 20250201-1
pavucontrol 1:6.1-1
picocom 3.1-3
picom 12.5-1
polkit-kde-agent 6.3.3-1
python-dbus-next 0.2.3-6
python-gpgme 1.24.2-1
qalculate-gtk 5.5.1-1
qmk 1.1.6-1
rclone 1.69.1-1
reflector 2023-3
remind 5.2.3-1
ristretto 0.13.4-1
rofi-pass 2.0.2-4
rtorrent 0.15.1-4
rxvt-unicode 9.31-7
sassc 3.6.2-5
slock 1.5-3
stalonetray 0.8.5-2
stow 2.4.1-1
sway 1:1.10.1-2
sxhkd 0.6.2-4
sxiv 26-2
testdisk 7.2-2
thunar-dropbox 0.3.1-1
tiny 0.13.0-1
trayer 1.1.8-4
ttf-0xproto-nerd 3.3.0-1
ttf-jetbrains-mono-nerd 3.3.0-1
ttf-noto-nerd 3.3.0-1
udiskie 2.5.7-1
ueberzug 18.3.1-4
vimiv 0.9.1-9
vivaldi 7.2.3621.71-1
vlc 3.0.21-16
vmware-workstation 16.2.1-2
wezterm 20240203.110809.5046fc22-2
wikiman 2.13.2-2
xdg-user-dirs 0.18-2
xf86-video-vesa 2.6.0-2
xfdesktop 4.20.1-1
xfwm4-themes 4.10.0-6
yazi 25.3.2-1
zola 0.20.0-1

## Todo
- [Wezterm Tab Bar](https://blog.dm4.tw/wezterm-tab-width-fill-tab-bar-eng)
- Opacity in tmux/neovim?
