# Dotfiles

This is a collection of my dotfiles. I am just starting to build them up in March of 2017. I am currently running an [Arch Linux](https://www.archlinux.org/) pseudo-server and am using an Apple laptop.

I will update this README with more links, tips, and information as I grow my dotfiles.

## Dotfile Management with GNU Stow and GitHub

I use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage my dotfiles. This allows me to easily create symlinks on any \*nix-based system I am using. I chose Stow because it is easily and universally available on \*nix machines. I do use Windows boxes, but I don"t see myself needing the majority of my dotfiles on those machines. One tool I found when looking for Windows alternatives is [stow-lite](https://github.com/ericsubach/stow-lite) but I have not used it yet. I also chose stow because I would be able to use it to manage config files that are not in ~/. In the future, I can use stow to deploy centralized config files across my system(s). 
 
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
- [Nathaniel Landau"s Bash Profile Gist](https://gist.github.com/natelandau/10654137/)

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
- ttf-dejavu
- noto-fonts-emoji
- otf-commit-mono-nerd
- ttf-nerd-fonts-symbols
- ttf-nerd-fonts-symbols-common
- ttf-nerd-fonts-symbols-mono
- adwaita-fonts
- NerdFont in Repo
- to "install" nerd font from repo, stow it then "fc-cache -f -v"
- gtk font picker: gtk2fontsel
- other gtk settings: lxappearance
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
- adwaita gtk
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

- To resolve the "permission denied" error when trying to access the Trash in Terminal on macOS, ensure that the Terminal app has Full Disk Access. You can do this by going to System Preferences > Security & Privacy > Privacy tab, unlocking the settings, and adding Terminal to the Full Disk Access list.

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
- pomodoro timers?
- https://github.com/SylvanFranklin/omni-preview.nvm
- https://github.com/SylvanFranklin/awesome-typst
- https://github.com/AndrewRadev/id3.vim
- icons for keepass in lf
- https://github.com/artempyanykh/marksman/
- start colors off and toggle on with f4
- SET UP A SEARCH FOR A FILE IN lf WHERE IT NAVIGATES TO THAT DIRECTORY
- clarify vim.bo vs vim.opt_local
    - https://github.com/neovim/neovim/pull/27708
    - https://github.com/neovim/neovim/issues/27671
    - https://github.com/neovim/neovim/pull/30733
    - https://github.com/neovim/neovim/issues/14670
- write entire color processing script vivid > lf colors > vidir vim syntax
- fabian dotfiles look at how handles aliases and look at other shell and fzf
- do fd/find -f recursive and such in lf for renaming?
- [dotfile management](https://mywiki.wooledge.org/DotFiles)
- [lsd](https://github.com/lsd-rs) vs eza
- glow config
    - https://github.com/LazyVim/LazyVim/discussions/2184
- make autocmd file for nvim?
- look into formatting that is not ALE?
- copy diagnostic to clipboard?
- customize fzf
    - https://github.com/junegunn/fzf/blob/master/ADVANCED.md
    - https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
    - josean's dotfiles
- Remove wikiman ctrl+f and move tmux to that so fzf can use its keybinds? rename wikiman to wm or something in alias and add that to ignorelist
- wikiman replacement for the arch wiki docs search using just fzf?
- https://github.com/yokoffing/BetterFox --> resetup firefox? user.js and what it entails
- lf https://github.com/atanunq/viu for image viewing?
- see if on-quit of lf can do what lfcd does
- more lf configs including ruler
- vivid setup https://github.com/sharkdp/vivid
- set up sudoedit / sudo -e in lf?
- fd and set it up instead of find
- set up fzf color scheme
- set up a lf for windows -> see pwsh examples
- install and config zathura on macbook
- learn [direnv](https://direnv.net/)
- move from paru to yay - lib update delay?
- clean up references and make them easier to read/into md make cheatsheets
    - css for cheatsheets of my own?
- Fix sessionizer-tmux
- [Wezterm Tab Bar](https://blog.dm4.tw/wezterm-tab-width-fill-tab-bar-eng)
- Opacity in tmux/neovim?
- [Set up delta?](https://github.com/scottmckendry/cyberdream.nvim/tree/main/extras/textmate#bat)
- [Eza Theme](https://github.com/eza-community/eza-themes/blob/main/themes/catppuccin.yml)
- [LS_COLORS](https://github.com/sharkdp/vivid?tab=readme-ov-file)
- how to use blink-cmp with visual/clipboard stuff?
- [dircolors - nord](https://github.com/nordtheme/dircolors)
- real vim plugin for pairing characters
- fd
- Brewfile
- [update snippets to a different UUID from v4?](https://andyatkinson.com/avoid-uuid-version-4-primary-keys)
- [learn and config trash-cli](https://github.com/andreafrancia/trash-cli)
- learn about editorconfig
- learn vim marks
- treesitter folding vs what i have already in vimrc: https://github.com/nvim-treesitter/nvim-treesitter
- migrate from paru to [yay](https://github.com/Jguer/yay) 
    - how to get the news checked before or back to w3?
- pass and GPG/PGP keys and/or keepass-cli to get secrets
- [set satty keybinds](https://github.com/Satty-org/Satty/issues/296)
- customize vifm and openers
    - https://old.reddit.com/r/vifm/comments/190u5zg/useful_command_to_create_files_and_directories/
- make dircolors theme: https://github.com/dracula/dircolors

in the .bashrc
- custom actions to file manager: https://www.youtube.com/watch?v=i28UNDO8Q7E&pp=ygUYZGlzdHJvdHViZSBmaWxlIGV4cGxvcmVy
- thunar vs pcmanfm
- customize mimeapps and lf opener and vifm opener see if you can make icons work for lf, vifm, and eza/lsd same for colors
- implement with vidir and fzf etc:
alias f="find . -type f -not -path '*/.git/*'"
alias ff="find . -type f -not -path '*/.git/*' | vidir -"

### Neovim
Maria icon implementation also look at her fzf-lua and lsp and settings
- snippet for keys and commands nvim - skels?
- function  to copy diagnostic under cursor
- remove comments from newline in nvim: https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
- plain text dict and thesarus lookup especcialy dict in neovim, see blink docs
to vimrc:
" === Custom commands ===
  command! MakeDir !mkdir -p %:h
  command! WlCopy w !wl-copy
  command! XCopy w !xclip -sel cli
Also, the quality of life improvements like `alias ..='cd ..'`, or mapping `l` such that it either opens a pager or lists a dir, depending on the argument. I'd never come up with those, and they're beyond useful.
- https://github.com/stevearc/conform.nvim

I imagine it's something like:

    l() { if [ -d "$1" ] ; then ls -alFh -- "$1" ; else "${PAGER:-pager}" -- "$1" ; fi }

- https://github.com/garymjr/nvim-snippets
- oerride nvim-web-devicons - especially file for the one in ls 
- learn more about localleader and neovim mappings
- decide gitsigns.nvim vs [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
- learn and configure [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- learn and configure [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [take what I want from unimpared](https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt)
- tpope commentary vs [comment.nvim](https://github.com/numToStr/Comment.nvim)
- [nvim-notify - looks cool, probably an unnecessary thing with messages](https://github.com/rcarriga/nvim-notify)
- [csvview.nvim: an option for csv handling in neovim](https://github.com/hat0uma/csvview.nvim)
- Possible ALE replacements?
    - [nvim-lint](https://github.com/mfussenegger/nvim-lint)
    - [conform.nvim](https://github.com/stevearc/conform.nvim)

vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })

combine some pickers -> spell and lsp? help and keys? :lua FzfLua.combine({ pickers = "oldfiles;git_files" })
-- or using the `FzfLua` vim command:
:FzfLua combine pickers=oldfiles;git_files

### Neovim LSP
recommendation: don't put the same on_attach for each server, you can use :h LspAttach instead

the actual problem with your code is that :h vim.lsp.enable does not take the config as a 2nd parameter. you have to pass that config into :h vim.lsp.config before enabling.

also strongly recommend reading :h lsp-config


https://vi.stackexchange.com/questions/46749/correct-way-to-utilize-on-attach-in-the-new-vim-lsp-config-setup-in-neovim-v0-11

https://neovim.io/doc/user/lsp.html

THIS ONE PROBABLY BEST: https://stephenvantran.com/posts/2025-10-29-setup-neovim-lsp-011/

https://old.reddit.com/r/neovim/comments/1bljfoi/lspattach_autocommand_vs_on_attach_for_setting/
#### Neovim 0.12
- [moving to builtin plugin manager neovim](https://bower.sh/nvim-builtin-plugin-mgr)
    - this includes some functions for the new treesitter

OMNI BORDER COLOR: https://github.com/neovim/neovim/pull/25541
## Software to Learn/Research
- [modern unix tools](https://github.com/johnalanwoods/maintained-modern-unix)
- mpv vs vlc
- poppler
- [websocat](https://github.com/vi/websocat)
- [restish](https://github.com/rest-sh/restish)
- lazygit
- [trash-cli](https://github.com/andreafrancia/trash-cli)
- [delta](https://github.com/dandavison/delta)
- [espanso text expander](https://github.com/espanso/espanso)
- userChrome.css for Firefox? https://github.com/ericmurphyxyz/userchrome.css
- [curlie](https://github.com/rs/curlie) vs httpie
- [gowall](https://github.com/Achno/gowall)
## Color Palette
I use [Cyberdream](https://github.com/scottmckendry/cyberdream.nvim) wherever possible. I may work on a utility to convert [Dracula](https://draculatheme.com/spec) or [Catppuccin](https://catppuccin.com/) themes to Cyberdream. For now, I am using the tables below if I have to search and replace.

Notes:
- backgr/bg = background
- foregr/fg = foreground

### Light Cyberdream

| Hex                                               | Color        |
| --------------------------------------------------| ------------ |
| [#ffffff](https://www.color-hex.com/color/ffffff) | bg           |
| [#eaeaea](https://www.color-hex.com/color/eaeaea) | bg_alt       |
| [#acacac](https://www.color-hex.com/color/acacac) | bg_highlight |
| [#16181a](https://www.color-hex.com/color/16181a) | fg           |
| [#7b8496](https://www.color-hex.com/color/7b8496) | gray         |
| [#0057d1](https://www.color-hex.com/color/0057d1) | blue         |
| [#008b0c](https://www.color-hex.com/color/008b0c) | green        |
| [#008c99](https://www.color-hex.com/color/008c99) | cyan         |
| [#d11500](https://www.color-hex.com/color/d11500) | red          |
| [#997b00](https://www.color-hex.com/color/997b00) | yellow       |
| [#d100bf](https://www.color-hex.com/color/d100bf) | magenta      |
| [#f40064](https://www.color-hex.com/color/f40064) | pink         |
| [#d17c00](https://www.color-hex.com/color/d17c00) | orange       |
| [#a018ff](https://www.color-hex.com/color/a018ff) | purple       |

### Dark Cyberdream

| Hex                                               | Color           |
| ------------------------------------------------- | --------------- |
| [#16181a](https://www.color-hex.com/color/16181a) | cd-bg           |
| [#1e2124](https://www.color-hex.com/color/1e2124) | cd-bg_alt       |
| [#3c4048](https://www.color-hex.com/color/3c4048) | cd-bg_hi        |
| [#ffffff](https://www.color-hex.com/color/ffffff) | cd-fg           |
| [#7b8496](https://www.color-hex.com/color/7b8496) | cd-gray         |
| [#5ea1ff](https://www.color-hex.com/color/5ea1ff) | cd-blue         |
| [#5eff6c](https://www.color-hex.com/color/5eff6c) | cd-green        |
| [#5ef1ff](https://www.color-hex.com/color/5ef1ff) | cd-cyan         |
| [#ff6e5e](https://www.color-hex.com/color/ff6e5e) | cd-red          |
| [#f1ff5e](https://www.color-hex.com/color/f1ff5e) | cd-yellow       |
| [#ff5ef1](https://www.color-hex.com/color/ff5ef1) | cd-magenta      |
| [#ff5ea0](https://www.color-hex.com/color/ff5ea0) | cd-pink         |
| [#ffbd5e](https://www.color-hex.com/color/ffbd5e) | cd-orange       |
| [#bd5eff](https://www.color-hex.com/color/bd5eff) | cd-purple       |
