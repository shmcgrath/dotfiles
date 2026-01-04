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
- lf https://github.com/atanunq/viu for image viewing?
- see if on-quit of lf can do what lfcd does
- set up sudoedit / sudo -e in lf?
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
### Neovim
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
#### Neovim 0.12
- [moving to builtin plugin manager neovim](https://bower.sh/nvim-builtin-plugin-mgr)
    - this includes some functions for the new treesitter
## Software to Learn/Research
- mpv vs vlc
- poppler
- [websocat](https://github.com/vi/websocat)
- [restish](https://github.com/rest-sh/restish)
- lazygit
- [trash-cli](https://github.com/andreafrancia/trash-cli)
- [delta](https://github.com/dandavison/delta)
- [espanso text expander](https://github.com/espanso/espanso)

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


| Syntax Category               | Cyberdream Color | Cyberdream Style | Catppuccin Color           | Catppuccin Style             | Notes / Use                         |
| ----------------------------- | ---------------- | ---------------- | -------------------------- | ---------------------------- | ----------------------------------- |
| Comment                       | grey             | italic           | link → Comment             | -                        | Regular comments                    |
| Comment.Documentation         | grey             | italic           | link → Comment             | -                        | Doc comments / docstrings           |
| Comment.Todo                  | purple           | bold             | flamingo                   | -                        | TODO notes                          |
| Comment.Warning               | red              | -                | base + yellow bg           | -                        | Warnings in comments                |
| Comment.Error                 | red              | -                | base + red bg              | -                        | Errors in comments                  |
| Comment.Hint                  | -                | -                | base + blue bg             | -                        | Hints in comments                   |
| Comment.Note                  | -                | -                | base + rosewater bg        | -                        | Notes in comments                   |
| Constant                      | pink             | -                | link → Constant            | -                        | Constants                           |
| Constant.Builtin              | cyan             | -                | peach                      | `Os.keywords`            | Built-in constants                  |
| Constant.Macro                | purple           | -                | link → Macro               | -                        | Macro constants                     |
| String                        | green            | -                | link → String              | -                        | Strings                             |
| String.Documentation          | -                | -                | teal                       | `Os.strings`             | Docstrings in Python, etc.          |
| String.Regex                  | -                | -                | pink                       | `Os.strings`             | Regex literals                      |
| String.Escape                 | -                | -                | pink                       | `Os.strings`             | Escaped characters                  |
| String.Special                | -                | -                | link → Special             | -                        | Special strings (dates, symbols)    |
| String.Special.Path           | -                | -                | link → Special             | -                        | File paths                          |
| String.Special.Symbol         | flamingo         | -                | flamingo                   | -                        | Symbols / atoms                     |
| String.Special.URL            | cyan             | italic           | blue                       | italic + underline       | URLs / links                        |
| Character                     | green            | -                | link → Character           | -                        | Character literals                  |
| Character.Special             | -                | -                | link → SpecialChar         | -                        | Special characters like wildcards   |
| Boolean                       | cyan             | -                | link → Boolean             | -                        | Boolean literals                    |
| Number                        | orange           | -                | link → Number              | -                        | Numbers                             |
| Number.Float                  | orange           | -                | link → Float               | -                        | Floating-point numbers              |
| Identifier                    | fg               | -                | text                       | -                        | Generic identifiers                 |
| Variable                      | fg               | -                | text                       | `Os.variables`           | Generic variables                   |
| Variable.Builtin              | fg               | -                | red                        | `Os.properties`          | Built-in variables (`self`, `this`) |
| Variable.Parameter            | fg               | -                | maroon                     | `Os.variables`           | Function parameters                 |
| Variable.Member               | grey             | -                | lavender                   | -                        | Object / member variables           |
| Property                      | fg               | -                | lavender                   | `Os.properties`          | Object / class properties           |
| Function                      | blue             | -                | link → Function            | -                        | Function definitions                |
| Function.Builtin              | blue             | -                | peach                      | `Os.functions`           | Built-in functions                  |
| Function.Call                 | blue             | -                | link → Function            | -                        | Function calls                      |
| Function.Macro                | blue             | -                | pink                       | `Os.functions`           | Macro functions                     |
| Function.Method               | blue             | -                | link → Function            | -                        | Method definitions                  |
| Function.Method.Call          | blue             | -                | link → Function            | -                        | Method calls                        |
| Constructor                   | fg               | -                | yellow                     | -                        | Constructor calls / definitions     |
| Operator                      | purple           | -                | link → Operator            | -                        | Operators (`+`, `-`, etc.)          |
| Keyword                       | orange           | -                | link → Keyword             | -                        | General keywords                    |
| Keyword.Function              | orange           | -                | mauve                      | `Os.keywords`            | Function definition keywords        |
| Keyword.Operator              | orange           | -                | mauve                      | `Os.keywords`            | Operator keywords                   |
| Keyword.Import                | -                | -                | link → Include             | -                        | Imports/includes                    |
| Keyword.Repeat                | -                | -                | link → Repeat              | -                        | Loop keywords                       |
| Keyword.Conditional           | -                | -                | link → Conditional         | -                        | Conditional keywords                |
| Keyword.Exception             | -                | -                | link → Exception           | -                        | Exception keywords                  |
| Keyword.Storage               | -                | -                | link → Keyword.Modifier    | -                        | Storage-class keywords              |
| Keyword.Modifier              | -                | -                | link → Keyword.Modifier    | -                        | Modifiers (`const`, `static`)       |
| Keyword.Coroutine             | -                | -                | link → Keyword             | -                        | Coroutines (`async/await`, `go`)    |
| Keyword.Directive             | -                | -                | link → PreProc             | -                        | Preprocessor directives / shebangs  |
| Keyword.Directive.Define      | -                | -                | link → Define              | -                        | Preprocessor defines                |
| Type                          | purple           | -                | link → Type                | -                        | User-defined types                  |
| Type.Builtin                  | purple           | -                | mauve                      | `Os.properties` / italic | Built-in types                      |
| Type.Definition               | -                | -                | link → Type                | -                        | Type definitions (`typedef`)        |
| Attribute                     | fg               | -                | link → Constant            | -                        | Decorators / attributes            
| PreProc                       | cyan             | -                | link → PreProc             | -                        | Preprocessor directives             |
| Delimiter                     | fg               | -                | link → Delimiter           | -                        | Delimiters (`;`, `,`)               |
| Punctuation.Delimiter         | -                | -                | link → Delimiter           | -                        | Delimiters                          |
| Punctuation.Bracket           | fg               | -                | overlay2                   | -                        | Brackets / parentheses              |
| Punctuation.Special           | -                | -                | link → Special             | -                        | Special punctuation                 |
| Special                       | pink             | -                | link → Special             | -                        | Special symbols / characters        |
| Underlined                    | -                | underline        | link → Underlined          | -                        | Underlined text                     |
| Bold                          | -                | bold             | -                          | bold                     | Bold text                           |
| Italic                        | -                | italic           | -                          | italic                   | Italic text                         |
| Error                         | red              | -                | red                        | -                        | Errors                              |
| Todo                          | purple           | bold             | flamingo                   | -                        | TODOs                               |
| Markup                        | -                | -                | text                       | -                        | Text in markup languages            |
| Markup.Strong                 | -                | -                | red                        | bold                     | Bold text in markup                 |
| Markup.Italic                 | -                | -                | red                        | italic                   | Italic text in markup               |
| Markup.Strikethrough          | -                | -                | text                       | strikethrough            | Strikethrough text                  |
| Markup.Underline              | -                | -                | link → Underlined          | -                        | Underlined markup text              |
| Markup.Heading                | -                | -                | blue                       | -                        | Headings                            |
| Markup.Heading.Markdown       | -                | -                | style → bold               | -                        | Markdown headings                   |
| Markup.Math                   | -                | -                | blue                       | -                        | Math environments (`$...$`)         |
| Markup.Quote                  | -                | -                | pink                       | -                        | Block quotes                        |
| Markup.Environment            | -                | -                | pink                       | -                        | Text environments in markup         |
| Markup.Environment.Name       | -                | -                | blue                       | -                        | Environment type names              |
| Markup.Link                   | -                | -                | lavender                   | -                        | References, citations               |
| Markup.Link.Label             | -                | -                | lavender                   | -                        | Link labels                         |
| Markup.Link.URL               | -                | -                | blue                       | italic + underline       | URLs in markup                      |
| Markup.Raw                    | -                | -                | green                      | -                        | Inline code / docstrings            |
| Markup.List                   | -                | -                | teal                       | -                        | Lists                               |
| Markup.List.Checked           | -                | -                | green                      | -                        | Checked TODOs                       |
| Markup.List.Unchecked         | -                | -                | overlay1                   | -                        | Unchecked TODOs                     |
| Diff.Add                      | -                | -                | link → diffAdded           | -                        | Diff added text                     |
| Diff.Minus                    | -                | -                | link → diffRemoved         | -                        | Diff removed text                   |
| Diff.Delta                    | -                | -                | link → diffChanged         | -                        | Diff changed text                   |
| Tag                           | -                | -                | blue                       | -                        | HTML / JSX tag names                |
| Tag.Builtin                   | -                | -                | blue                       | -                        | JSX tag names                       |
| Tag.Attribute                 | -                | -                | yellow                     | `Os.miscs` / italic      | HTML/XML attributes                 |
| Tag.Delimiter                 | -                | -                | teal                       | -                        | `< > /` tag delimiters              |
| gitcommitSummary              | -                | italic           | rosewater                  | `Os.miscs`               | Git commit summary line             |
| zshKSHFunction                | -                | -                | link → Function            | -                        | Zsh/KSH function names              |
| CSS.Property                  | -                | -                | blue                       | -                        | CSS properties                      |
| CSS.Property.ID/Class         | -                | -                | yellow                     | -                        | CSS id/class names                  |
| CSS.Type.Tag                  | -                | -                | blue                       | -                        | CSS tag types                       |
| CSS.Number                    | -                | -                | peach                      | -                        | Numbers in CSS                      |
| HTML.String.Special.URL       | -                | -                | green                      | -                        | Links in HTML attributes            |
| Lua.Constructor               | -                | -                | link → Punctuation.Bracket | -                        | Table / constructor                 |
| Python.Constructor            | -                | -                | sky                        | -                        | `__init__`, `__new__`               |
| YAML.Label                    | -                | -                | yellow                     | -                        | Anchor / alias names                |
| Ruby.String.Special.Symbol    | flamingo         | -                | flamingo                   | -                        | Special symbols                     |
| PHP.Function.Method           | -                | -                | link → Function            | -                        | Method definitions                  |
| PHP.Function.Method.Call      | -                | -                | link → Function            | -                        | Method calls                        |
| C/C++.Keyword.Import          | -                | -                | yellow                     | -                        | Include / import statements         |
| C#.Attribute                  | -                | -                | yellow                     | -                        | Attributes in C#                    |
| GitCommit.Comment.Warning     | -                | -                | yellow                     | -                        | Warnings in gitcommit               |
| GitIgnore.String.Special.Path | -                | -                | text                       | -                        | File paths in gitignore             |


| Group      | Usage                         | Color (Cyberdream) | Style               |
| ---------- | ----------------------------- | ------------------ | ------------------- |
| **Syntax** |                               |                    |                     |
| Comment    | Comments                      | grey               | italic (if enabled) |
| String     | Strings                       | green              |                     |
| Character  | Characters                    | green              |                     |
| Boolean    | Booleans                      | cyan               |                     |
| Number     | Numbers                       | orange             |                     |
| Identifier | Variables, identifiers        | fg (default)       |                     |
| Function   | Functions                     | blue               |                     |
| Statement  | Statements                    | magenta            |                     |
| Operator   | Operators                     | purple             |                     |
| Keyword    | Keywords (if/for/while)       | orange             |                     |
| PreProc    | Preprocessor directives       | cyan               |                     |
| Label      | Labels                        | orange             |                     |
| Type       | Types                         | purple             |                     |
| Special    | Special constants             | pink               |                     |
| Delimiter  | Delimiters (brackets, commas) | fg (default)       |                     |
| Debug      | Debug code                    | orange             |                     |
| Underlined | Underlined text               | -                  | underline           |
| Bold       | Bold text                     | -                  | bold                |
| Italic     | Italic text                   | -                  | italic              |
| Error      | Error text                    | red                |                     |
| Todo       | TODO comments                 | purple             | bold                |
| UI / Vim ||||
| ColorColumn | Color column | bg_highlight | |
| Conceal | Concealed text | grey | |
| Cursor | Cursor | fg=bg, bg=fg | |
| CursorColumn | Highlighted column | bg_highlight | |
| CursorLine | Highlighted line | bg_highlight | |
| Directory | Directory names | blue | |
| DiffAdd | Added lines (diff) | green blended | |
| DiffChange | Changed lines | blue blended | |
| DiffDelete | Deleted lines | red blended | |
| DiffText | Changed text | orange blended | |
| Added | Added text | green | |
| Removed | Removed text | red | |
| EndOfBuffer | ~ lines at end | blended grey | |
| ErrorMsg | Error messages | red | |
| VertSplit / WinSeparator | Window splits | bg_highlight | |
| Folded / FoldColumn | Folded text | grey | |
| SignColumn | Signs | grey | |
| Substitute | Substitute highlight | fg=red, bg=bg_highlight | |
| LineNr | Line numbers | blended fg | |
| CursorLineNr | Current line number | grey | |
| MatchParen | Matching brackets | pink | |
| ModeMsg / MsgArea | Messages | fg | |
| MoreMsg | More messages | blue | |
| NonText | Non-text chars | blended grey | |
| Normal / NormalNC / NormalFloat | Default text | fg/bg | |
| FloatTitle | Floating window title | cyan | |
| FloatBorder | Floating window border | fg=bg_highlight | |
| Pmenu / PmenuSel / PmenuSbar / PmenuThumb | Popup menu | fg/bg | |
| Question | Prompt | yellow | |
| QuickFixLine | Quickfix highlight | bg_highlight | |
| Search / IncSearch / CurSearch | Search highlights | fg/bg_alt, fg/cyan | |
| SpecialKey | Special keys | grey | |
| SpellBad / SpellCap / SpellLocal / SpellRare | Spell checker | red/yellow/blue/purple | undercurl |
| StatusLine / StatusLineNC | Status line | fg/bg | grey for inactive |
| TabLine / TabLineFill / TabLineSel | Tab line | fg/bg | |
| WinBar / WinBarNC | Window bar | fg/bg | grey for inactive |
| Title | Window title | fg | |
| Visual / VisualNOS | Visual selection | bg_highlight | |
| WarningMsg | Warning messages | orange | |
| Whitespace | Whitespace chars | bg_highlight | |
| WildMenu | Command completion menu | fg/bg | |

| LSP / Diagnostics ||||
| LspReferenceText / LspReferenceRead / LspReferenceWrite | Highlight references | bg_highlight | |
| DiagnosticError | Errors | red | |
| DiagnosticWarn | Warnings | yellow | |
| DiagnosticInfo | Info | blue | |
| DiagnosticHint | Hints | cyan | |
| DiagnosticUnnecessary | Unused code | grey | |
| DiagnosticVirtualTextError / Warn / Info / Hint | Virtual text | red/yellow/blue/cyan | |
| DiagnosticUnderlineError / Warn / Info / Hint | Underline for diagnostics | red/yellow/blue/cyan | undercurl |
| LspSignatureActiveParameter | Active parameter | orange | |
| LspCodeLens / LspInlayHint | Code lens / inlay hints | grey | |
| LspInfoBorder | Info window border | bg | |

| Markdown / Special ||||
| htmlH1 / markdownH1 | H1 headings | orange | bold |
| htmlH2 / markdownH2 | H2 headings | orange/cyan | bold |
| markdownH3 | H3 | blue | bold |
| markdownH4 | H4 | purple | bold |
| markdownH5 | H5 | magenta | bold |
| markdownH6 | H6 | green | bold |
| markdownLinkText | Links | blue | underline |
| mkdCodeStart / mkdCodeEnd | Code block delimiters | blue | |
| mkdCodeDelimiter / markdownHeadingDelimiter | Markdown delimiters | grey | |
| markdownCode / markdownCodeBlock | Inline code / code blocks | cyan | |

Cyberdream Highlight Reference
Category	Highlight Group	Color (Hex)	Style
Syntax	Comment	#7b8496	italic (optional)
Syntax	String	#5eff6c	
Syntax	Character	#5eff6c	
Syntax	Boolean	#5ef1ff	
Syntax	Number	#ffbd5e	
Syntax	Identifier	#ffffff	
Syntax	Function	#5ea1ff	
Syntax	Statement	#bd5eff	
Syntax	Operator	#bd5eff	
Syntax	Keyword	#ffbd5e	
Syntax	PreProc	#5ef1ff	
Syntax	Label	#ffbd5e	
Syntax	Type	#bd5eff	
Syntax	Special	#ff5ea0	
Syntax	Delimiter	#ffffff	
Syntax	Debug	#ffbd5e	
Text	Underlined	—	underline
Text	Bold	—	bold
Text	Italic	—	italic
Text	Error	#ff6e5e	
Text	Todo	#bd5eff	bold

| Editor UI | Normal | fg=#ffffff<br>bg=#16181a | |
| Editor UI | NormalNC | fg=#ffffff<br>bg=#16181a | |
| Editor UI | NormalFloat | fg=#ffffff<br>bg=#16181a | |
| Editor UI | LineNr | blended fg=#ffffff | |
| Editor UI | CursorLineNr | #7b8496 | |
| Editor UI | EndOfBuffer | blended #3c4048 | |
| Editor UI | ColorColumn | #3c4048 | |
| Editor UI | MatchParen | fg=#ff5ea0, bg=#3c4048 | |
| Editor UI | Pmenu | fg=#ffffff, bg=#16181a | |
| Editor UI | PmenuSel | fg=#ffffff, bg=#3c4048 | |
| Editor UI | PmenuSbar | bg=#3c4048 | |
| Editor UI | PmenuThumb | bg=#3c4048 | |
| Editor UI | VertSplit | fg=#3c4048, bg=#16181a | |
| Editor UI | WinSeparator | fg=#3c4048, bg=#16181a | |
| Editor UI | Folded | #7b8496 | |
| Editor UI | FoldColumn | #7b8496 | |
| Editor UI | SignColumn | #7b8496 | |
| Editor UI | Substitute | fg=#ff6e5e, bg=#3c4048 | |
| Editor UI | Visual | bg=#3c4048 | |
| Editor UI | VisualNOS | bg=#3c4048 | |
| Editor UI | Search | fg=#1e2124, bg=#ffffff | |
| Editor UI | IncSearch | fg=#1e2124, bg=#5ef1ff | |
| Editor UI | CurSearch | fg=#1e2124, bg=#5ef1ff | |
| Editor UI | QuickFixLine | bg=#3c4048 | |
| Editor UI | WildMenu | fg=#16181a, bg=#5ea1ff | |

| Floating Windows / Borders | FloatTitle | fg=#5ef1ff, bg=#16181a | |
| Floating Windows / Borders | FloatBorder | fg=#3c4048, bg=#16181a | |

| Status & Mode | StatusLine | fg=#ffffff, bg=#16181a | |
| Status & Mode | StatusLineNC | fg=#7b8496, bg=#16181a | |
| Status & Mode | TabLine | fg=#7b8496, bg=#16181a | |
| Status & Mode | TabLineFill | fg=#7b8496, bg=#16181a | |
| Status & Mode | TabLineSel | fg=#ffffff, bg=#3c4048 | |
| Status & Mode | WinBar | fg=#ffffff, bg=#16181a | |
| Status & Mode | WinBarNC | fg=#7b8496, bg=#16181a | |
| Status & Mode | Title | #ffffff | |

| Spell & Whitespace | SpellBad | undercurl=#ff6e5e | |
| Spell & Whitespace | SpellCap | undercurl=#f1ff5e | |
| Spell & Whitespace | SpellLocal | undercurl=#5ea1ff | |
| Spell & Whitespace | SpellRare | undercurl=#bd5eff | |
| Spell & Whitespace | Whitespace | #3c4048 | |
| Spell & Whitespace | SpecialKey | #7b8496 | |

| Diagnostics (LSP) | DiagnosticError | #ff6e5e | |
| Diagnostics (LSP) | DiagnosticWarn | #f1ff5e | |
| Diagnostics (LSP) | DiagnosticInfo | #5ea1ff | |
| Diagnostics (LSP) | DiagnosticHint | #5ef1ff | |
| Diagnostics (LSP) | DiagnosticUnnecessary | #7b8496 | |
| Diagnostics (LSP) | DiagnosticUnderlineError | undercurl=#ff6e5e | |
| Diagnostics (LSP) | DiagnosticUnderlineWarn | undercurl=#f1ff5e | |
| Diagnostics (LSP) | DiagnosticUnderlineInfo | undercurl=#5ea1ff | |
| Diagnostics (LSP) | DiagnosticUnderlineHint | undercurl=#5ef1ff | |
| Diagnostics (LSP) | LspSignatureActiveParameter | #ffbd5e | |
| Diagnostics (LSP) | LspCodeLens | #7b8496 | |
| Diagnostics (LSP) | LspInlayHint | #7b8496 | |

| Markdown / Special | markdownH1 | #ffbd5e | bold |
| Markdown / Special | markdownH2 | #5ef1ff | bold |
| Markdown / Special | markdownH3 | #5ea1ff | bold |
| Markdown / Special | markdownH4 | #bd5eff | bold |
| Markdown / Special | markdownH5 | #ff5ef1 | bold |
| Markdown / Special | markdownH6 | #5eff6c | bold |
| Markdown / Special | markdownLinkText | #5ea1ff | underline |
| Markdown / Special | mkdCodeStart | #5ea1ff | |
| Markdown / Special | mkdCodeEnd | #5ea1ff | |
| Markdown / Special | mkdCodeDelimiter | #7b8496 | |
| Markdown / Special | markdownHeadingDelimiter | #7b8496 | |


### Dark Cyberdream Translation
| Color            | Cyberdream | Dracula  | Macchiato | Mocha   |
|------------------|------------|----------|-----------|---------|
| background       | #16181a    | #282a36  | #24273a   | #1e1e2e |
| foreground       | #ffffff    | #f8f8f2  | #cad3f5   | #cdd6f4 |

| Color Function | Color Name | Latte   | Frappé  | Macchiato | Mocha   |
| -------------- | ---------- | ------- | ------- | --------- | ------- |
|                | Rosewater  | #dc8a78 | #f2d5cf | #f4dbd6   | #f5e0dc |
|                | Flamingo   | #dd7878 | #eebebe | #f0c6c6   | #f2cdcd |
|                | Pink       | #ea76cb | #f4b8e4 | #f5bde6   | #f5c2e7 |
|                | Mauve      | #8839ef | #ca9ee6 | #c6a0f6   | #cba6f7 |
|                | Red        | #d20f39 | #e78284 | #ed8796   | #f38ba8 |
|                | Maroon     | #e64553 | #ea999c | #ee99a0   | #eba0ac |
|                | Peach      | #fe640b | #ef9f76 | #f5a97f   | #fab387 |
|                | Yellow     | #df8e1d | #e5c890 | #eed49f   | #f9e2af |
|                | Green      | #40a02b | #a6d189 | #a6da95   | #a6e3a1 |
|                | Teal       | #179299 | #81c8be | #8bd5ca   | #94e2d5 |
|                | Sky        | #04a5e5 | #99d1db | #91d7e3   | #89dceb |
|                | Sapphire   | #209fb5 | #85c1dc | #7dc4e4   | #74c7ec |
|                | Blue       | #1e66f5 | #8caaee | #8aadf4   | #89b4fa |
|                | Lavender   | #7287fd | #babbf1 | #b7bdf8   | #b4befe |
|                | Text       | #4c4f69 | #c6d0f5 | #cad3f5   | #cdd6f4 |
|                | Subtext 1  | #5c5f77 | #b5bfe2 | #b8c0e0   | #bac2de |
|                | Subtext 0  | #6c6f85 | #a5adce | #a5adcb   | #a6adc8 |
|                | Overlay 2  | #7c7f93 | #949cbb | #939ab7   | #9399b2 |
|                | Overlay 1  | #8c8fa1 | #838ba7 | #8087a2   | #7f849c |
|                | Overlay 0  | #9ca0b0 | #737994 | #6e738d   | #6c7086 |
|                | Surface 2  | #acb0be | #626880 | #5b6078   | #585b70 |
|                | Surface 1  | #bcc0cc | #51576d | #494d64   | #45475a |
|                | Surface 0  | #ccd0da | #414559 | #363a4f   | #313244 |
| Background     | Base       | #eff1f5 | #303446 | #24273a   | #1e1e2e |
|                | Mantle     | #e6e9ef | #292c3c | #1e2030   | #181825 |
|                | Crust      | #dce0e8 | #232634 | #181926   | #11111b |

| Color Name     | Rosé Pine (Main) | Rosé Pine Moon | Rosé Pine Dawn | Cyberdream | Purpose / Usage                               |
| -------------- | ---------------- | -------------- | -------------- | ---------- | --------------------------------------------- |
| Base           | #191724          | #232136        | #faf4ed        |            | Primary background                            |
| Surface        | #1f1d2e          | #2a273f        | #fffaf3        |            | Secondary background / UI panels              |
| Overlay        | #26233a          | #393552        | #f2e9e1        |            | Tertiary background / transient UI            |
| Muted          | #6e6a86          | #6e6a86        | #9893a5        |            | Low contrast foreground / hints               |
| Subtle         | #908caa          | #908caa        | #797593        |            | Medium contrast foreground / subtle text      |
| Text           | #e0def4          | #e0def4        | #575279        |            | High contrast text / primary text             |
| Love           | #eb6f92          | #eb6f92        | #b4637a        |            | Errors / diagnostics / alerts                 |
| Gold           | #f6c177          | #f6c177        | #ea9d34        |            | Diagnostic Warnings - strings                 | 
| Rose           | #ebbcba          | #ea9a97        | #d7827e        | #5ef1ff    | Accent / search / important highlights        |
| Pine           | #31748f          | #3e8fb0        | #286983        |            | Green / keywords / git additions              |
| Foam           | #9ccfd8          | #9ccfd8        | #56949f        |            | Blue / info / secondary highlights            |
| Iris           | #c4a7e7          | #c4a7e7        | #907aa9        |            | Magenta / hints / notifications               |
| Highlight Low  | #21202e          | #2a283e        | #f4ede8        |            | Cursorline / low intensity highlight          |
| Highlight Med  | #403d52          | #44415a        | #dfdad9        |            | Selection / medium intensity highlight        |
| Highlight High | #524f67          | #56526e        | #cecacd        |            | Borders / accents / high intensity highlights |


| Hex                                               | Color           |
| ------------------------------------------------- | --------------- |
| [#16181a](https://www.color-hex.com/color/16181a) | cd-bg           |
| [#1e2124](https://www.color-hex.com/color/1e2124) | cd-bg_alt       |
| [#3c4048](https://www.color-hex.com/color/3c4048) | cd-bg_hi        |
| [#ffffff](https://www.color-hex.com/color/ffffff) | cd-fg           |
| [#7b8496](https://www.color-hex.com/color/7b8496) | cd-gray         |
| [#5ea1ff](https://www.color-hex.com/color/5ea1ff) | cd-blue         |
| [#5eff6c](https://www.color-hex.com/color/5eff6c) | cd-green        |
| [#ff6e5e](https://www.color-hex.com/color/ff6e5e) | cd-red          |
| [#f1ff5e](https://www.color-hex.com/color/f1ff5e) | cd-yellow       |
| [#ff5ef1](https://www.color-hex.com/color/ff5ef1) | cd-magenta      |
| [#ff5ea0](https://www.color-hex.com/color/ff5ea0) | cd-pink         |
| [#ffbd5e](https://www.color-hex.com/color/ffbd5e) | cd-orange       |
| [#bd5eff](https://www.color-hex.com/color/bd5eff) | cd-purple       |
### alacritty comparison

#### alacritty dark

| Color           | Cyberdream | Dracula | Macchiato |  Mocha  |
| --------------- | ---------- | ------- | --------- | ------- |
| index 16        | #ffbd5e    |         | #f5a97f   | #fab387 |
| index 17        | #ff5ef1    |         | #f4dbd6   | #f5e0dc |
| bright black    | #3c4048    | #6272a4 | #5b6078   | #585b70 |
| bright blue     | #5ea1ff    | #d6acff | #8aadf4   | #89b4fa |
| bright cyan     | #5ef1ff    | #a4ffff | #8bd5ca   | #94e2d5 |
| bright green    | #5eff6c    | #69ff94 | #a6da95   | #a6e3a1 |
| bright magenta  | #bd5eff    | #ff92df | #f5bde6   | #f5c2e7 |
| bright red      | #ff6e5e    | #ff6e6e | #ed8796   | #f38ba8 |
| bright white    | #ffffff    | #ffffff | #a5adcb   | #a6adc8 |
| bright yellow   | #f1ff5e    | #ffffa5 | #eed49f   | #f9e2af |
| normal black    | #16181a    | #21222c | #494d64   | #45475a |
| normal blue     | #5ea1ff    | #bd93f9 | #8aadf4   | #89b4fa |
| normal cyan     | #5ef1ff    | #8be9fd | #8bd5ca   | #94e2d5 |
| normal green    | #5eff6c    | #50fa7b | #a6da95   | #a6e3a1 |
| normal magenta  | #bd5eff    | #ff79c6 | #f5bde6   | #f5c2e7 |
| normal red      | #ff6e5e    | #ff5555 | #ed8796   | #f38ba8 |
| normal white    | #ffffff    | #f8f8f2 | #b8c0e0   | #bac2de |
| normal yellow   | #f1ff5e    | #f1fa8c | #eed49f   | #f9e2af |
| primary backgr  | #16181a    | #282a36 | #24273a   | #1e1e2e |
| primary foregr  | #ffffff    | #f8f8f2 | #cad3f5   | #cdd6f4 |
| prim bright fg  |            | #ffffff | #cad3f5   | #cdd6f4 |
| primary dim fg  |            |         | #8087a2   | #7f849c |
| selection bg    | #3c4048    | #44475a | #f4dbd6   | #f5e0dc |
| selection fg    | #ffffff    |         |           |         |
| selection text  |            |         | #24273a   | #1e1e2e |
| cursor text     |            | #282a36 | #24273a   | #1e1e2e |
| cursor cursor   |            | #f8f8f2 | #f4dbd6   | #f5e0dc |
| vi cursor txt   |            |         | #24273a   | #1e1e2e |
| vi cursor curs  |            |         | #b7bdf8   | #b4befe |
| search match fg |            | #44475a | #24273a   | #1e1e2e |
| search match bg |            | #50fa7b | #a5adcb   | #a6adc8 |
| srch foc mch fg |            | #44475a | #24273a   | #1e1e2e |
| srch foc mch bg |            | #ffb86c | #a6da95   | #a6e3a1 |
| footer bar bg   |            | #282a36 | #a5adcb   | #a6adc8 |
| footer bar fg   |            | #f8f8f2 | #24273a   | #1e1e2e |
| hints start bg  |            | #282a36 | #eed49f   | #f9e2af |
| hints start fg  |            | #f1fa8c | #24273a   | #1e1e2e |
| hints end fg    |            | #f1fa8c | #24273a   | #1e1e2e |
| hints end bg    |            | #282a36 | #a5adcb   | #a6adc8 |

### Fish Comparison

| Color           | Cyberdream | Dracula | Macchiato |  Mocha  |
| --------------- | ---------- | ------- | --------- | ------- |
| background      | #16181a    | #282a36 | #24273a   | #1e1e2e |
| normal          | #ffffff    | #f8f8f2 | #cad3f5   | #cdd6f4 |
| command         | #5ef1ff    | #8be9fd | #8aadf4   | #89b4fa |
| param           | #ffaecf    | #bd93f9 | #f0c6c6   | #f2cdcd |
| keyword         | #5eff6c    | #ff79c6 | #c6a0f6   | #cba6f7 |
| quote           | #f1ff5e    | #f1fa8c | #a6da95   |         |
| redirection     | #5ea1ff    | #f8f8f2 | #f5bde6   | #f5c2e7 |
| end             | #bd5eff    | #ffb86c | #f5a97f   | #fab387 |
| comment         | #7b8496    | #6272a4 | #8087a2   | #7f849c |
| error           | #ff6e5e    | #ff5555 | #ed8796   | #f38ba8 |
| gray            | #7b8496    | —       | #6e738d   | #6c7086 |
| selection bg    | #3c4048    | #44475a | #363a4f   | #313244 |
| search_match bg | #3c4048    | #44475a | #363a4f   | #313244 |
| option          | #f1ff5e    | #ffb86c | #a6da95   | #a6e3a1 |
| operator        | #5ea1ff    | #50fa7b | #f5bde6   | #f5c2e7 |
| escape          | #ffaecf    | #ff79c6 | #ee99a0   | #eba0ac |
| autosuggestion  | #7b8496    | #6272a4 | #6e738d   | #6c7086 |
| cancel          | #ff6e5e    | #ff5555 | #ed8796   | #f38ba8 |
| cwd             | #ffbd5e    | #50fa7b | #eed49f   | #f9e2af |
| user            | #5ef5d2    | #8be9fd | #8bd5ca   | #94e2d5 |
| host            | #5eff6c    | #bd93f9 | #8aadf4   | #89b4fa |
| host_remote     | #f1ff5e    | #bd93f9 | #a6da95   | #a6e3a1 |
| status          | #ff6e5e    | #ff5555 | #ed8796   | #f38ba8 |
| pager_progress  | #7b8496    | #6272a4 | #6e738d   | #6c7086 |
| pager_prefix    | #5ea1ff    | #8be9fd | #f5bde6   | #f5c2e7 |
| pgr_completion  | #ffffff    | #f8f8f2 | #cad3f5   | #cdd6f4 |
| pgr_description | #7b8496    | #6272a4 | #6e738d   | #6c7086 |


### Foot Comparison
| Color            | Cyberdream | Dracula  | Macchiato | Mocha   |
|------------------|------------|----------|-----------|---------|
| background       | #16181a    | #282a36  | #24273a   | #1e1e2e |
| foreground       | #ffffff    | #f8f8f2  | #cad3f5   | #cdd6f4 |
| cursor bg        | #16181a    | —        | #181926   | #11111b |
| cursor fg        | #ffffff    | —        | #f4dbd6   | #f5e0dc |
| regular black    | #16181a    | #21222c  | #494d64   | #45475a |
| regular red      | #ff6e5e    | #ff5555  | #ed8796   | #f38ba8 |
| regular green    | #5eff6c    | #50fa7b  | #a6da95   | #a6e3a1 |
| regular yellow   | #f1ff5e    | #f1fa8c  | #eed49f   | #f9e2af |
| regular blue     | #5ea1ff    | #bd93f9  | #8aadf4   | #89b4fa |
| regular magenta  | #bd5eff    | #ff79c6  | #f5bde6   | #f5c2e7 |
| regular cyan     | #5ef1ff    | #8be9fd  | #8bd5ca   | #94e2d5 |
| regular white    | #ffffff    | #f8f8f2  | #b8c0e0   | #bac2de |
| bright black     | #3c4048    | #6272a4  | #5b6078   | #585b70 |
| bright red       | #ff6e5e    | #ff6e6e  | #ed8796   | #f38ba8 |
| bright green     | #5eff6c    | #69ff94  | #a6da95   | #a6e3a1 |
| bright yellow    | #f1ff5e    | #ffffa5  | #eed49f   | #f9e2af |
| bright blue      | #5ea1ff    | #d6acff  | #8aadf4   | #89b4fa |
| bright magenta   | #bd5eff    | #ff92df  | #f5bde6   | #f5c2e7 |
| bright cyan      | #5ef1ff    | #a4ffff  | #8bd5ca   | #94e2d5 |
| bright white     | #ffffff    | #ffffff  | #a5adcb   | #a6adc8 |
| index 16         | #d17c00    | —        | #f5a97f   | #fab387 |
| index 17         | #d100bf    | —        | #f4dbd6   | #f5e0dc |

### Ghostty Comparison
| Color / Slot          | Cyberdream | Dracula  | Macchiato | Mocha    |
|-----------------------|------------|----------|-----------|----------|
| cursor color          | #ffffff    | #f8f8f2  | #f4dbd6   | #f5e0dc  |
| cursor text           | —          | #282a36  | #181926   | #11111b  |
| selection background  | #3c4048    | #44475a  | #3a3e53   | #353749  |
| selection foreground  | #ffffff    | #f8f8f2  | #cad3f5   | #cdd6f4  |
| palette 0 (black)     | #16181a    | #21222c  | #494d64   | #45475a  |
| palette 1 (red)       | #ff6e5e    | #ff5555  | #ed8796   | #f38ba8  |
| palette 2 (green)     | #5eff6c    | #50fa7b  | #a6da95   | #a6e3a1  |
| palette 3 (yellow)    | #f1ff5e    | #f1fa8c  | #eed49f   | #f9e2af  |
| palette 4 (blue)      | #5ea1ff    | #bd93f9  | #8aadf4   | #89b4fa  |
| palette 5 (magenta)   | #bd5eff    | #ff79c6  | #f5bde6   | #f5c2e7  |
| palette 6 (cyan)      | #5ef1ff    | #8be9fd  | #8bd5ca   | #94e2d5  |
| palette 7 (white)     | #ffffff    | #f8f8f2  | #a5adcb   | #a6adc8  |
| palette 8 (bright 0)  | #3c4048    | #6272a4  | #5b6078   | #585b70  |
| palette 9 (bright 1)  | #ff6e5e    | #ff6e6e  | #ed8796   | #f38ba8  |
| palette 10 (bright 2) | #5eff6c    | #69ff94  | #a6da95   | #a6e3a1  |
| palette 11 (bright 3) | #f1ff5e    | #ffffa5  | #eed49f   | #f9e2af  |
| palette 12 (bright 4) | #5ea1ff    | #d6acff  | #8aadf4   | #89b4fa  |
| palette 13 (bright 5) | #bd5eff    | #ff92df  | #f5bde6   | #f5c2e7  |
| palette 14 (bright 6) | #5ef1ff    | #a4ffff  | #8bd5ca   | #94e2d5  |
| palette 15 (bright 7) | #ffffff    | #ffffff  | #b8c0e0   | #bac2de  |

### Kitty Comparison
| Color / Key | Cyberdream | Dracula | Macchiato | Mocha |
|------------|------------|---------|-----------|-------|
| background | #16181a | #282a36 | #24273a | #1e1e2e |
| foreground | #ffffff | #f8f8f2 | #cad3f5 | #cdd6f4 |
| cursor | #ffffff | #f8f8f2 | #f4dbd6 | #f5e0dc |
| cursor_text_color | #16181a | background | #24273a | #1e1e2e |
| selection_background | #3c4048 | #44475a | #f4dbd6 | #f5e0dc |
| selection_foreground | #ffffff | #ffffff | #24273a | #1e1e2e |
| active_tab_foreground | #000000 | #282a36 | #181926 | #11111b |
| active_tab_background | #ffbd5e | #f8f8f2 | #c6a0f6 | #cba6f7 |
| inactive_tab_foreground | #ffffff | #282a36 | #cad3f5 | #cdd6f4 |
| inactive_tab_background | #16181a | #6272a4 | #1e2030 | #181825 |
| color0 (black) | #16181a | #21222c | #494d64 | #45475a |
| color8 (bright black) | #3c4048 | #6272a4 | #5b6078 | #585b70 |
| color1 (red) | #ff6e5e | #ff5555 | #ed8796 | #f38ba8 |
| color9 (bright red) | #ff6e5e | #ff6e6e | #ed8796 | #f38ba8 |
| color2 (green) | #5eff6c | #50fa7b | #a6da95 | #a6e3a1 |
| color10 (bright green) | #5eff6c | #69ff94 | #a6da95 | #a6e3a1 |
| color3 (yellow) | #f1ff5e | #f1fa8c | #eed49f | #f9e2af |
| color11 (bright yellow) | #f1ff5e | #ffffa5 | #eed49f | #f9e2af |
| color4 (blue) | #5ea1ff | #bd93f9 | #8aadf4 | #89b4fa |
| color12 (bright blue) | #5ea1ff | #d6acff | #8aadf4 | #89b4fa |
| color5 (magenta) | #bd5eff | #ff79c6 | #f5bde6 | #f5c2e7 |
| color13 (bright magenta) | #bd5eff | #ff92df | #f5bde6 | #f5c2e7 |
| color6 (cyan) | #5ef1ff | #8be9fd | #8bd5ca | #94e2d5 |
| color14 (bright cyan) | #5ef1ff | #a4ffff | #8bd5ca | #94e2d5 |
| color7 (white) | #ffffff | #f8f8f2 | #b8c0e0 | #bac2de |
| color15 (bright white) | #ffffff | #ffffff | #a5adcb | #a6adc8 |

### WezTerm Comparison
| Color           | Cyberdream | Dracula                                    | Macchiato | Mocha   |
| --------------- | ---------- | ------------------------------------------ | --------- | ------- |
| foreground      | #ffffff    | #f8f8f2                                    | #cad3f5   | #cdd6f4 |
| background      | #16181a    | #282a36                                    | #24273a   | #1e1e2e |
| cursor_bg       | #ffffff    | #f8f8f2                                    | #f4dbd6   | #f5e0dc |
| cursor_fg       | #16181a    | #282a36                                    | #181926   | #11111b |
| cursor_border   | #ffffff    | #f8f8f2                                    | #f4dbd6   | #f5e0dc |
| selection_fg    | #ffffff    | rgba(0% 0% 0% 0%)                          | #cad3f5   | #cdd6f4 |
| selection_bg    | #3c4048    | rgba(26.666668% 27.843138% 35.294117% 50%) | #5b6078   | #585b70 |
| scrollbar_thumb | #16181a    | #44475a                                    | #5b6078   | #585b70 |
| split           | #16181a    | #6272a4                                    | #6e738d   | #6c7086 |
| ansi[0]         | #16181a    | #21222c                                    | #494d64   | #45475a |
| ansi[1]         | #ff6e5e    | #ff5555                                    | #ed8796   | #f38ba8 |
| ansi[2]         | #5eff6c    | #50fa7b                                    | #a6da95   | #a6e3a1 |
| ansi[3]         | #f1ff5e    | #f1fa8c                                    | #eed49f   | #f9e2af |
| ansi[4]         | #5ea1ff    | #bd93f9                                    | #8aadf4   | #89b4fa |
| ansi[5]         | #bd5eff    | #ff79c6                                    | #f5bde6   | #f5c2e7 |
| ansi[6]         | #5ef1ff    | #8be9fd                                    | #8bd5ca   | #94e2d5 |
| ansi[7]         | #ffffff    | #f8f8f2                                    | #b8c0e0   | #bac2de |
| brights[0]      | #3c4048    | #6272a4                                    | #5b6078   | #585b70 |
| brights[1]      | #ff6e5e    | #ff6e6e                                    | #ed8796   | #f38ba8 |
| brights[2]      | #5eff6c    | #69ff94                                    | #a6da95   | #a6e3a1 |
| brights[3]      | #f1ff5e    | #ffffa5                                    | #eed49f   | #f9e2af |
| brights[4]      | #5ea1ff    | #d6acff                                    | #8aadf4   | #89b4fa |
| brights[5]      | #bd5eff    | #ff92df                                    | #f5bde6   | #f5c2e7 |
| brights[6]      | #5ef1ff    | #a4ffff                                    | #8bd5ca   | #94e2d5 |
| brights[7]      | #ffffff    | #ffffff                                    | #a5adcb   | #a6adc8 |
| indexed[16]     | #ffbd5e    | -                                          | #f5a97f   | #fab387 |
| indexed[17]     | #ff6e5e    | -                                          | #f4dbd6   | #f5e0dc |

### Windows Terminal Comparison
| Color               | Cyberdream | Dracula | Macchiato | Mocha   |
| ------------------- | ---------- | ------- | --------- | ------- |
| foreground          | #ffffff    | #F8F8F2 | #CAD3F5   | #CDD6F4 |
| background          | #16181a    | #282A36 | #24273A   | #1E1E2E |
| cursorColor         | #ffffff    | #F8F8F2 | #F4DBD6   | #F5E0DC |
| selectionBackground | #3c4048    | #44475A | #5B6078   | #585B70 |
| black               | #16181a    | #21222C | #494D64   | #45475A |
| red                 | #ff6e5e    | #FF5555 | #ED8796   | #F38BA8 |
| green               | #5eff6c    | #50FA7B | #A6DA95   | #A6E3A1 |
| yellow              | #f1ff5e    | #F1FA8C | #EED49F   | #F9E2AF |
| blue                | #5ea1ff    | #BD93F9 | #8AADF4   | #89B4FA |
| purple              | #bd5eff    | #FF79C6 | #F5BDE6   | #F5C2E7 |
| cyan                | #5ef1ff    | #8BE9FD | #8BD5CA   | #94E2D5 |
| white               | #ffffff    | #F8F8F2 | #B8C0E0   | #BAC2DE |
| brightBlack         | #3c4048    | #6272A4 | #5B6078   | #585B70 |
| brightRed           | #ff6e5e    | #FF6E6E | #ED8796   | #F38BA8 |
| brightGreen         | #5eff6c    | #69FF94 | #A6DA95   | #A6E3A1 |
| brightYellow        | #f1ff5e    | #FFFFA5 | #EED49F   | #F9E2AF |
| brightBlue          | #5ea1ff    | #D6ACFF | #8AADF4   | #89B4FA |
| brightPurple        | #bd5eff    | #FF92DF | #F5BDE6   | #F5C2E7 |
| brightCyan          | #5ef1ff    | #A4FFFF | #8BD5CA   | #94E2D5 |
| brightWhite         | #ffffff    | #FFFFFF | #A5ADCB   | #A6ADC8 |


### TextMate Comparison
| Color                 | Cyberdream | Dracula | Macchiato | Mocha |
| --------------------- | ---------- | ------- | --------- | ----- |
| Background            | #16181a    | #282a36 |           |       |
| Foreground            | #ffffff    | #f8f8f2 |           |       |
| Caret                 | #ffffff    | #f8f8f0 |           |       |
| Line Highlight        | #3c4048    | #44475a |           |       |
| Selection             | #3c4048    | #44475a |           |       |
| Comment               | #7b8496    | #6272a4 |           |       |
| String                | #5eff6c    | #f1fa8c |           |       |
| Number                | #ffffff    | #bd93f9 |           |       |
| Built-in constant     | #ffffff    | #bd93f9 |           |       |
| User-defined constant | #ffffff    | #bd93f9 |           |       |
| Keyword               | #ffbd5e    | #ff79c6 |           |       |
| Storage type          | #5ef1ff    | #8be9fd |           |       |
| Class name            | #bd5eff    | #50fa7b |           |       |
| Function name         | #5ea1ff    | #50fa7b |           |       |
| Function argument     | #bd5eff    | #ffb86c |           |       |
| Tag name              | #5ef1ff    | #ff79c6 |           |       |
| Tag attribute         | #5ef1ff    | #50fa7b |           |       |
| Library function      | #5ea1ff    | #8be9fd |           |       |
| Library constant      | #ffffff    | #6be5fd |           |       |
| Inherited class       | #bd5eff    | #50fa7b |           |       |
| Invalid               | #ff5ea0    | #ff5555 |           |       |


### Additional Comparisons to Do
- [LSD](https://github.com/catppuccin/lsd/blob/main/themes/catppuccin-mocha/colors.yaml)
- ColorLS

#### base16 dark
- https://github.com/catppuccin/base16
| Color           | Cyberdream | Dracula | Macchiato |  Mocha  |
| --------------- | ---------- | ------- | --------- | ------- |
| base00          | #16181a    | #282936 | #         | #       |
| base01          | #1e2124    | #3a3c4e | #         | #       |
| base02          | #3c4048    | #4d4f68 | #         | #       |
| base03          | #7b8496    | #626483 | #         | #       |
| base04          | #7b8496    | #62d6e8 | #         | #       |
| base05          | #ffffff    | #e9e9f4 | #         | #       |
| base06          | #16181a    | #f1f2f8 | #         | #       |
| base07          | #ffffff    | #f7f7fb | #         | #       |
| base08          | #ff6e5e    | #ea51b2 | #         | #       |
| base09          | #ffbd5e    | #b45bcf | #         | #       |
| base0A          | #f1ff5e    | #00f769 | #         | #       |
| base0B          | #5eff6c    | #ebff87 | #         | #       |
| base0C          | #5ef1ff    | #a1efe4 | #         | #       |
| base0D          | #5ea1ff    | #62d6e8 | #         | #       |
| base0E          | #bd5eff    | #b45bcf | #         | #       |
| base0F          | #ff5ef1    | #00f769 | #         | #       |


### Catpuccin
| Flavor     | Color Name   | Hex       |
|------------|--------------|-----------|
| Latte      | Rosewater    | #dc8a78   |
| Latte      | Flamingo     | #dd7878   |
| Latte      | Pink         | #ea76cb   |
| Latte      | Mauve        | #8839ef   |
| Latte      | Red          | #d20f39   |
| Latte      | Maroon       | #e64553   |
| Latte      | Peach        | #fe640b   |
| Latte      | Yellow       | #df8e1d   |
| Latte      | Green        | #40a02b   |
| Latte      | Teal         | #179299   |
| Latte      | Sky          | #04a5e5   |
| Latte      | Sapphire     | #209fb5   |
| Latte      | Blue         | #1e66f5   |
| Latte      | Lavender     | #7287fd   |
| Latte      | Text         | #4c4f69   |
| Latte      | Subtext 1    | #5c5f77   |
| Latte      | Subtext 0    | #6c6f85   |
| Latte      | Overlay 2    | #7c7f93   |
| Latte      | Overlay 1    | #8c8fa1   |
| Latte      | Overlay 0    | #9ca0b0   |
| Latte      | Surface 2    | #acb0be   |
| Latte      | Surface 1    | #bcc0cc   |
| Latte      | Surface 0    | #ccd0da   |
| Latte      | Base         | #eff1f5   |
| Latte      | Mantle       | #e6e9ef   |
| Latte      | Crust        | #dce0e8   |
| Frappé     | Rosewater    | #f2d5cf   |
| Frappé     | Flamingo     | #eebebe   |
| Frappé     | Pink         | #f4b8e4   |
| Frappé     | Mauve        | #ca9ee6   |
| Frappé     | Red          | #e78284   |
| Frappé     | Maroon       | #ea999c   |
| Frappé     | Peach        | #ef9f76   |
| Frappé     | Yellow       | #e5c890   |
| Frappé     | Green        | #a6d189   |
| Frappé     | Teal         | #81c8be   |
| Frappé     | Sky          | #99d1db   |
| Frappé     | Sapphire     | #85c1dc   |
| Frappé     | Blue         | #8caaee   |
| Frappé     | Lavender     | #babbf1   |
| Frappé     | Text         | #c6d0f5   |
| Frappé     | Subtext 1    | #b5bfe2   |
| Frappé     | Subtext 0    | #a5adce   |
| Frappé     | Overlay 2    | #949cbb   |
| Frappé     | Overlay 1    | #838ba7   |
| Frappé     | Overlay 0    | #737994   |
| Frappé     | Surface 2    | #626880   |
| Frappé     | Surface 1    | #51576d   |
| Frappé     | Surface 0    | #414559   |
| Frappé     | Base         | #303446   |
| Frappé     | Mantle       | #292c3c   |
| Frappé     | Crust        | #232634   |
| Macchiato  | Rosewater    | #f4dbd6   |
| Macchiato  | Flamingo     | #f0c6c6   |
| Macchiato  | Pink         | #f5bde6   |
| Macchiato  | Mauve        | #c6a0f6   |
| Macchiato  | Red          | #ed8796   |
| Macchiato  | Maroon       | #ee99a0   |
| Macchiato  | Peach        | #f5a97f   |
| Macchiato  | Yellow       | #eed49f   |
| Macchiato  | Green        | #a6da95   |
| Macchiato  | Teal         | #8bd5ca   |
| Macchiato  | Sky          | #91d7e3   |
| Macchiato  | Sapphire     | #7dc4e4   |
| Macchiato  | Blue         | #8aadf4   |
| Macchiato  | Lavender     | #b7bdf8   |
| Macchiato  | Text         | #cad3f5   |
| Macchiato  | Subtext 1    | #b8c0e0   |
| Macchiato  | Subtext 0    | #a5adcb   |
| Macchiato  | Overlay 2    | #939ab7   |
| Macchiato  | Overlay 1    | #8087a2   |
| Macchiato  | Overlay 0    | #6e738d   |
| Macchiato  | Surface 2    | #5b6078   |
| Macchiato  | Surface 1    | #494d64   |
| Macchiato  | Surface 0    | #363a4f   |
| Macchiato  | Base         | #24273a   |
| Macchiato  | Mantle       | #1e2030   |
| Macchiato  | Crust        | #181926   |
| Mocha      | Rosewater    | #f5e0dc   |
| Mocha      | Flamingo     | #f2cdcd   |
| Mocha      | Pink         | #f5c2e7   |
| Mocha      | Mauve        | #cba6f7   |
| Mocha      | Red          | #f38ba8   |
| Mocha      | Maroon       | #eba0ac   |
| Mocha      | Peach        | #fab387   |
| Mocha      | Yellow       | #f9e2af   |
| Mocha      | Green        | #a6e3a1   |
| Mocha      | Teal         | #94e2d5   |
| Mocha      | Sky          | #89dceb   |
| Mocha      | Sapphire     | #74c7ec   |
| Mocha      | Blue         | #89b4fa   |
| Mocha      | Lavender     | #b4befe   |
| Mocha      | Text         | #cdd6f4   |
| Mocha      | Subtext 1    | #bac2de   |
| Mocha      | Subtext 0    | #a6adc8   |
| Mocha      | Overlay 2    | #9399b2   |
| Mocha      | Overlay 1    | #7f849c   |
| Mocha      | Overlay 0    | #6c7086   |
| Mocha      | Surface 2    | #585b70   |
| Mocha      | Surface 1    | #45475a   |
| Mocha      | Surface 0    | #313244   |
| Mocha      | Base         | #1e1e2e   |
| Mocha      | Mantle       | #181825   |
| Mocha      | Crust        | #11111b   |

| Color Name | Mocha   | Cyberdream |
| ---------- | ------- | ---------- |
| Rosewater  | #f5e0dc | #ff6e5e    |
| Flamingo   | #f2cdcd | #ff6e5e    |
| Pink       | #f5c2e7 | #bd5eff    |
| Mauve      | #cba6f7 | #bd5eff    |
| Red        | #f38ba8 | #ff6e5e    |
| Maroon     | #eba0ac | #ff6e5e    |
| Peach      | #fab387 | #ffbd5e    |
| Yellow     | #f9e2af | #f1ff5e    |
| Green      | #a6e3a1 | #5eff6c    |
| Teal       | #94e2d5 | #5ef1ff    |
| Sky        | #89dceb | #5ea1ff    |
| Sapphire   | #74c7ec | #5ea1ff    |
| Blue       | #89b4fa | #5ea1ff    |
| Lavender   | #b4befe | #bd5eff    |
| Text       | #cdd6f4 | #ffffff    |
| Subtext 1  | #bac2de | #7b8496    |
| Subtext 0  | #a6adc8 | #7b8496    |
| Overlay 2  | #9399b2 | #3c4048    |
| Overlay 1  | #7f849c | #3c4048    |
| Overlay 0  | #6c7086 | #16181a    |
| Surface 2  | #585b70 | #3c4048    |
| Surface 1  | #45475a | #16181a    |
| Surface 0  | #313244 | #16181a    |
| Base       | #1e1e2e | #16181a    |
| Mantle     | #181825 | #16181a    |
| Crust      | #11111b | #16181a    |

| Dracula        | Hex     | RGB           | Usage                        | Cyberdream |
| -------------- | ------- | ------------- | ---------------------------- | ---------- |
| Background     | #282A36 | 40, 42, 54    | Main background              | #16181a    |
| Current Line   | #6272A4 | 98, 114, 164  | Comments, disabled code      | #3c4048    |
| Selection      | #44475A | 68, 71, 90    | Text selection               | #3c4048    |
| Foreground     | #F8F8F2 | 248, 248, 242 | Default text                 | #ffffff    |
| Comment        | #6272A4 | 98, 114, 164  | Comments, disabled code      | #7b8496    |
| Red            | #FF5555 | 255, 85, 85   | Errors, warnings, deletion   | #ff6e5e    |
| Orange         | #FFB86C | 255, 184, 108 | Numbers, constants, booleans | #ffbd5e    |
| Yellow         | #F1FA8C | 241, 250, 140 | Functions, methods           | #f1ff5e    |
| Green          | #50FA7B | 80, 250, 123  | Strings, inherited classes   | #5eff6c    |
| Cyan           | #8BE9FD | 139, 233, 253 | Support functions, regex     | #5ef1ff    |
| Purple         | #BD93F9 | 189, 147, 249 | Classes, types, variables    | #bd5eff    |
| Magenta        | #FF79C6 | 255, 121, 198 | Additional accents           | #bd5eff    |
| Bright Red     | #FF6E6E | 255, 110, 110 | Bright error                 | #ff6e5e    |
| Bright Green   | #69FF94 | 105, 255, 148 | Bright string                | #5eff6c    |
| Bright Yellow  | #FFFFA5 | 255, 255, 165 | Bright function              | #f1ff5e    |
| Bright Blue    | #D6ACFF | 214, 172, 255 | Bright class/type            | #5ea1ff    |
| Bright Magenta | #FF92DF | 255, 146, 223 | Bright accent                | #bd5eff    |
| Bright Cyan    | #A4FFFF | 164, 255, 255 | Bright support               | #5ef1ff    |
| Bright White   | #FFFFFF | 255, 255, 255 | Default bright               | #ffffff    |




### Dracula

#### Classic
| Token         | Hex     | RGB          | HSL              | Usage                             |
|---------------|---------|--------------|------------------|-----------------------------------|
| Background    | #282A36 | 40, 42, 54   | 231°, 15%, 18%   | Main background                   |
| Current Line  | #6272A4 | 98, 114, 164 | 225°, 27%, 51%   | Comments, disabled code           |
| Selection     | #44475A | 68, 71, 90   | 232°, 14%, 31%   | Text selection                    |
| Foreground    | #F8F8F2 | 248, 248, 242| 60°, 30%, 96%    | Default text                      |
| Comment       | #6272A4 | 98, 114, 164 | 225°, 27%, 51%   | Comments, disabled code           |
| Red           | #FF5555 | 255, 85, 85  | 0°, 100%, 67%    | Errors, warnings, deletion        |
| Orange        | #FFB86C | 255, 184, 108| 31°, 100%, 71%   | Numbers, constants, booleans      |
| Yellow        | #F1FA8C | 241, 250, 140| 65°, 92%, 76%    | Functions, methods                |
| Green         | #50FA7B | 80, 250, 123 | 135°, 94%, 65%   | Strings, inherited classes        |
| Cyan          | #8BE9FD | 139, 233, 253| 191°, 97%, 77%   | Support functions, regex          |
| Purple        | #BD93F9 | 189, 147, 249| 265°, 89%, 78%   | Classes, types, variables         |
| Pink          | #FF79C6 | 255, 121, 198| 326°, 100%, 74%  | Keywords, storage types           |

##### ANSI Color Palette

| ANSI Token         | Hex     | RGB          |
|--------------------|---------|--------------|
| AnsiBlack          | #21222C | 33, 34, 44   |
| AnsiRed            | #FF5555 | 255, 85, 85  |
| AnsiGreen          | #50FA7B | 80, 250, 123 |
| AnsiYellow         | #F1FA8C | 241, 250, 140|
| AnsiBlue           | #BD93F9 | 189, 147, 249|
| AnsiMagenta        | #FF79C6 | 255, 121, 198|
| AnsiCyan           | #8BE9FD | 139, 233, 253|
| AnsiWhite          | #F8F8F2 | 248, 248, 242|
| AnsiBrightBlack    | #6272A4 | 98, 114, 164 |
| AnsiBrightRed      | #FF6E6E | 255, 110, 110|
| AnsiBrightGreen    | #69FF94 | 105, 255, 148|
| AnsiBrightYellow   | #FFFFA5 | 255, 255, 165|
| AnsiBrightBlue     | #D6ACFF | 214, 172, 255|
| AnsiBrightMagenta  | #FF92DF | 255, 146, 223|
| AnsiBrightCyan     | #A4FFFF | 164, 255, 255|
| AnsiBrightWhite    | #FFFFFF | 255, 255, 255|

##### UI Color Palette
| Context                        | Hex     | RGB          | HSL            |
|--------------------------------|---------|--------------|----------------|
| Floating interactive elements  | #343746 | 52, 55, 70   | 225°, 15%, 24% |
| Background Lighter             | #424450 | 66, 68, 80   | 231°, 10%, 29% |
| Background Light               | #343746 | 52, 55, 70   | 225°, 15%, 24% |
| Background Dark                | #21222C | 33, 34, 44   | 235°, 14%, 15% |
| Background Darker              | #191A21 | 25, 26, 33   | 232°, 14%, 11% |



#### Alucard
| Token         | Hex     | RGB          | HSL              | Usage                             |
|---------------|---------|--------------|------------------|-----------------------------------|
| Background    | #FFFBEB | 255, 251, 235| 48°, 100%, 96%   | Main background                   |
| Current Line  | #6C664B | 108, 102, 75 | 49°, 18%, 36%    | Line highlight                    |
| Selection     | #CFCFDE | 207, 207, 222| 240°, 18%, 84%   | Text selection                    |
| Foreground    | #1F1F1F | 31, 31, 31   | 0°, 0%, 12%      | Default text                      |
| Comment       | #6C664B | 108, 102, 75 | 49°, 18%, 36%    | Comments, disabled code           |
| Red           | #CB3A2A | 203, 58, 42  | 6°, 66%, 48%     | Errors, warnings, deletion        |
| Orange        | #A34D14 | 163, 77, 20  | 24°, 78%, 36%    | Numbers, constants, booleans      |
| Yellow        | #846E15 | 132, 110, 21 | 48°, 73%, 30%    | Functions, methods                |
| Green         | #14710A | 20, 113, 10  | 114°, 84%, 24%   | Strings, inherited classes        |
| Cyan          | #036A96 | 3, 106, 150  | 198°, 96%, 30%   | Support functions, regex          |
| Purple        | #644AC9 | 100, 74, 201 | 252°, 54%, 54%   | Classes, types, variables         |
| Pink          | #A3144D | 163, 20, 77  | 336°, 78%, 36%   | Keywords, storage types           |

##### ANSI Color Palette
| ANSI Token         | Hex     | RGB          |
|--------------------|---------|--------------|
| AnsiBlack          | #FFFBEB | 255, 251, 235|
| AnsiRed            | #CB3A2A | 203, 58, 42  |
| AnsiGreen          | #14710A | 20, 113, 10  |
| AnsiYellow         | #846E15 | 132, 110, 21 |
| AnsiBlue           | #644AC9 | 100, 74, 201 |
| AnsiMagenta        | #A3144D | 163, 20, 77  |
| AnsiCyan           | #036A96 | 3, 106, 150  |
| AnsiWhite          | #1F1F1F | 31, 31, 31   |
| AnsiBrightBlack    | #6C664B | 108, 102, 75 |
| AnsiBrightRed      | #D74C3D | 215, 76, 61  |
| AnsiBrightGreen    | #198D0C | 25, 141, 12  |
| AnsiBrightYellow   | #9E841A | 158, 132, 26 |
| AnsiBrightBlue     | #7862D0 | 120, 98, 208 |
| AnsiBrightMagenta  | #BF185A | 191, 24, 90  |
| AnsiBrightCyan     | #047FB4 | 4, 127, 180  |
| AnsiBrightWhite    | #2C2B31 | 44, 43, 49   |


##### UI Color Palette
| Context                        | Hex     | RGB          | HSL            |
|--------------------------------|---------|--------------|----------------|
| Floating interactive elements  | #EFEDDC | 239, 237, 220| 54°, 37%, 90%  |
| Background Lighter             | #ECE9DF | 236, 233, 223| 46°, 25%, 90%  |
| Background Light               | #DEDCCF | 222, 220, 207| 52°, 19%, 84%  |
| Background Dark                | #CECCC0 | 206, 204, 192| 51°, 13%, 78%  |
| Background Darker              | #BCBAB3 | 188, 186, 179| 47°, 6%, 72%   |

#### Functional Colors
| Token             | Hex     | RGB          | HSL            | Usage                         |
|-------------------|---------|--------------|----------------|-------------------------------|
| Functional Red    | #DE5735 | 222, 87, 53  | 12°, 71%, 54%  | Critical actions, alerts      |
| Functional Orange | #A39514 | 163, 149, 20 | 54°, 78%, 36%  | Warnings, notifications       |
| Functional Green  | #089108 | 8, 145, 8    | 120°, 90%, 30% | Success states                |
| Functional Cyan   | #0081D6 | 0, 129, 214  | 204°, 100%, 42%| Information, links            |
| Functional Purple | #815CD6 | 129, 92, 214 | 258°, 61%, 60% | Focus indicators              |

#### Syyntax Highlighting Rules

##### Token Classification

Following TextMate scoping conventions for consistent highlighting across editors.

##### Primary Tokens

###### Keywords & Storage → Pink
- Language Keywords: if, else, return, function, class;
- Storage Modifiers: static, public, private, const, let, var;
- Control Flow: try, catch, throw, break, continue.

###### Functions & Methods → Yellow
- Function Declarations and Calls;
- Method Invocations;
- Built-in Functions.

###### Classes & Types → Purple
- Class Names and Constructors;
- Type Annotations: int, string, boolean;
- Interfaces and Enums;
- Generic Type Parameters.

###### Strings & Text → Green
- String Literals: "Dracula", 'Dracula', template;
- Markup Text Content;
- Attribute Values in HTML/XML;
- Escape Sequences.

###### Numbers & Constants → Orange
- Numeric Literals: 42, 3.14, 0xFF, 1e5;
- Boolean Values: true, false;
- Language Constants: null, undefined, NaN.

###### Comments → Comment
- Single-Line: //, #, --;
- Multi-Line: /* */, <!-- -->;
- Documentation Blocks;
- Annotations and Decorators.

###### Support & Built-ins → Cyan
- Built-in Classes and Functions;
- Regular Expressions;
- CSS Properties and Units;
- HTML/XML Tag and Attribute Names;
- Library Functions.

###### Variables & Identifiers → Foreground
- Variable Names and Parameters;
- Object Properties;
- Default Text Content.

###### Errors & Warnings → Red
- Syntax Errors;
- Deprecated Code;
- Invalid Tokens;
- Diff Deletions.

##### Styling Modifiers
- Italic: Comments, type parameters, documentation;
- Bold: Strong emphasis (use sparingly);
- Underline: Links, misspelled words.

##### Special Rules
- Braces and Parentheses: Should match the foreground color of the currently scoped position:
    - Purple for headings;
    - Foreground for regular text.
- Instance Reserved Words: Words that interact with the instance (this, self, super) should be highlighted consistently;
- Generic Templates: Generic type declarations should use Orange Italic.

### Cyberdream vivid Theme for Reference
| Category    | Item                   | Foreground | Background | Font Style |
| ----------- | ---------------------- | ---------- | ---------- | ---------- |
| core        | normal_text            | white      |            |            |
| core        | regular_file           | white      |            |            |
| core        | reset_to_normal        | orange     |            |            |
| core        | directory              | purple     |            |            |
| core        | symlink                | cyan       |            |            |
| core        | multi_hard_link        |            |            |            |
| core        | fifo                   | yellow     | black      |            |
| core        | socket                 | pink       | black      | bold       |
| core        | door                   | pink       | black      | bold       |
| core        | block_device           | yellow     | black      | bold       |
| core        | character_device       | yellow     | black      | bold       |
| core        | broken_symlink         | red        | black      | bold       |
| core        | missing_symlink_target | red        | black      |            |
| core        | setuid                 | white      | red        |            |
| core        | setgid                 | black      | yellow     |            |
| core        | file_with_capability   |            |            |            |
| core        | sticky_other_writable  | black      | green      |            |
| core        | other_writable         | purple     | green      |            |
| core        | sticky                 | white      | purple     |            |
| core        | executable_file        | green      |            |            |
| text        | special                | orange     |            |            |
| text        | todo                   | orange     |            | bold       |
| text        | licenses               | orange     |            |            |
| text        | configuration          | orange     |            |            |
| text        | other                  | orange     |            |            |
| markup      | foreground             | orange     |            |            |
| programming | foreground             | orange     |            |            |
| media       | image                  | pink       |            |            |
| media       | audio                  | cyan       |            |            |
| media       | video                  | orange     |            | bold       |
| media       | fonts                  | orange     |            |            |
| media       | 3d                     | pink       |            |            |
| office      | foreground             | orange     |            |            |
| archives    | foreground             | red        |            | bold       |
| executable  | foreground             | green      |            |            |
| unimportant | foreground             | base01     |            |            |

### Cyberdream Yazi
[manager]
 tmTheme files can be found here: https://github.com/scottmckendry/cyberdream.nvim/tree/main/extras/textmate 
syntect_theme = "../bat/themes/cyberdream.tmTheme"
border_style = { fg = "#3c4048" }
cwd = { fg = "#5ef1ff" }
find_keyword = { bold = true, fg = "#5eff6c" }
find_position = { fg = "#ffffff" }
hovered = { bg = "#7b8496", bold = true, fg = "#ffffff" }
marker_copied = { bg = "#f1ff5e", fg = "#f1ff5e" }
marker_cut = { bg = "#ff6e5e", fg = "#ff6e5e" }
marker_selected = { bg = "#3c4048", fg = "#5eff6c" }
preview_hovered = { bg = "#3c4048", bold = true, fg = "#ffffff" }
tab_active = { bg = "#5ea1ff", fg = "#16181a" }
tab_inactive = { bg = "#3c4048", fg = "#ffffff" }

count_selected = { bg = "#5eff6c", fg = "#16181a" }
count_copied = { bg = "#f1ff5e", fg = "#16181a" }
count_cut = { bg = "#ff6e5e", fg = "#16181a" }

[completion]
active = { bg = "#7b8496", fg = "#bd5eff" }
border = { fg = "#5ea1ff" }
inactive = { fg = "#ffffff" }

[filetype]
rules = [
    { fg = "#5ef1ff", mime = "image/*" },
    { fg = "#f1ff5e", mime = "video/*" },
    { fg = "#f1ff5e", mime = "audio/*" },
    { fg = "#bd5eff", mime = "application/zip" },
    { fg = "#bd5eff", mime = "application/gzip" },
    { fg = "#bd5eff", mime = "application/x-tar" },
    { fg = "#bd5eff", mime = "application/x-bzip" },
    { fg = "#bd5eff", mime = "application/x-bzip2" },
    { fg = "#bd5eff", mime = "application/x-7z-compressed" },
    { fg = "#bd5eff", mime = "application/x-rar" },
    { fg = "#bd5eff", mime = "application/xz" },
    { fg = "#5eff6c", mime = "application/doc" },
    { fg = "#5eff6c", mime = "application/pdf" },
    { fg = "#5eff6c", mime = "application/rtf" },
    { fg = "#5eff6c", mime = "application/vnd.*" },
    { bold = true, fg = "#5ea1ff", mime = "inode/directory" },
    { fg = "#ffffff", mime = "*" }
]

[help]
desc = { fg = "#ffffff" }
footer = { fg = "#ffffff" }
hovered = { bg = "#7b8496", fg = "#ffffff" }
on = { fg = "#bd5eff" }
run = { fg = "#5ef1ff" }

[input]
border = { fg = "#5ea1ff" }
selected = { bg = "#7b8496" }
title = { fg = "#ffffff" }
value = { fg = "#ffffff" }

[select]
active = { fg = "#bd5eff" }
border = { fg = "#5ea1ff" }
inactive = { fg = "#ffffff" }

[status]
mode_normal = { bg = "#5ea1ff", bold = true, fg = "#16181a" }
mode_select = { bg = "#5eff6c", bold = true, fg = "#16181a" }
mode_unset = { bg = "#ff5ef1", bold = true, fg = "#16181a" }
permissions_r = { fg = "#f1ff5e" }
permissions_s = { fg = "#5ef1ff" }
permissions_t = { fg = "#5ea1ff" }
permissions_w = { fg = "#ff6e5e" }
permissions_x = { fg = "#5eff6c" }
progress_error = { bg = "#16181a", fg = "#ff6e5e" }
progress_label = { bg = "#16181a", fg = "#ffffff" }
progress_normal = { bg = "#16181a", fg = "#ffffff" }
separator_style = { bg = "#3c4048", fg = "#3c4048" }

[tasks]
border = { fg = "#5ea1ff" }
hovered = { bg = "#7b8496", fg = "#ffffff" }
title = { fg = "#ffffff" }

[which]
cand = { fg = "#5ef1ff" }
desc = { fg = "#ffffff" }
mask = { bg = "#3c4048" }
rest = { fg = "#ff5ef1" }
separator_style = { fg = "#7b8496" }

