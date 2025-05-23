DOTFILES := $(CURDIR)
BOOTSTRAP_DIR := $(CURDIR)/scripts/bootstrap
MKDIR := mkdir -pv
LN := ln -svf
LNDIR := ln --symbolic --verbose
PKGMAN := $(shell command -v paru >/dev/null 2>&1 && printf '%s' paru || printf '%s' sudo pacman)
PKGINSTALL = $(PKGMAN) --sync --needed
AURINSTALL = paru --sync --needed
STOW := stow --target=$(HOME)
CAT := $(shell command -v bat >/dev/null 2>&1 && printf '%s' bat || printf '%s' cat)
XDG_DATA_HOME  := $(shell [ -n "$$XDG_DATA_HOME" ] && printf %s "$$XDG_DATA_HOME" || printf %s "$(HOME)/.local/share")
XDG_CACHE_HOME := $(shell [ -n "$$XDG_CACHE_HOME" ] && printf %s "$$XDG_CACHE_HOME" || printf %s "$(HOME)/.cache")
XDG_CONFIG_HOME := $(shell [ -n "$$XDG_CONFIG_HOME" ] && printf %s "$$XDG_CONFIG_HOME" || printf %s "$(HOME)/.config")
XDG_STATE_HOME  := $(shell [ -n "$$XDG_STATE_HOME" ] && printf %s "$$XDG_STATE_HOME" || printf %s "$(HOME)/.local/state")

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
    OS := macos
else ifeq ($(UNAME_S),Linux)
    OS := linux
else ifeq ($(UNAME_S),OpenBSD)
    OS := openbsd
else ifneq (,$(findstring MINGW,$(UNAME_S)))
    OS := windows
else
    OS := unknown
endif


#by using ‘sudo -E make’ or ‘sudo -Es’ before running make, would source your env and make it available for sudoer.
# Stow packages

# Find subdirs and make them under $HOME
MAKE_DIRS = cd $@ && \
	find . -type d -print | sed 's|^\./||' | while IFS= read -r dir; do \
		[ -n "$$dir" ] && $(MKDIR) "$$HOME/$$dir"; \
	done

.PHONY: all clean stow aur pacman wayland xorg hyprland shellbase bash navi zoxide bin rust neovim vifm fzf dropbox xdg-dirs vim vim-base

all: vim neovim vim-base

pacman:
	$(MKDIR) $(HOME)/.config/pacman


sudoas:
	$(PKGINSTALL) doas
	@printf "configure doas"
	@printf "configure sudo"
	@printf "doas visudo"
	@printf "uncomment Defaults targetpw"
	@printf "uncomment ALL ALL = (ALL:ALL) ALL"
	@printf "replace the first all with username allowed to sudo"

aur:
	$(MKDIR) $(XDG_CACHE_HOME)/aur/aur
	$(MKDIR) $(XDG_CACHE_HOME)/aur/pkgbuilds
	$(MKDIR) $(XDG_CACHE_HOME)/aur/build/sources
	$(MKDIR) $(XDG_CACHE_HOME)/aur/build/srcpackages
	$(MKDIR) $(XDG_CACHE_HOME)/aur/build/makepkglogs
	$(MKDIR) $(XDG_CONFIG_HOME)/paru
	$(PKGINSTALL) base-devel
	@cd "$(XDG_CACHE_HOME)/aur/pkgbuilds" && \
	git clone https://aur.archlinux.org/paru.git && \
	cd "$(XDG_CACHE_HOME)/aur/pkgbuilds/paru" && \
	makepkg --syncdeps --install

dropbox:
	$(AURINSTALL) dropbox dropbox-cli
	# Prevent automatic updates
	#@rm -rf $(HOME)/.dropbox-dist
	#@install -dm0 $(HOME)/.dropbox-dist
	# Fix Arch filesystem monitoring problem (inotify fix)
	@if ! grep -q '^fs.inotify.max_user_watches = 100000' /etc/sysctl.d/99-sysctl.conf 2>/dev/null; then \
		printf "Adding fs.inotify.max_user_watches setting...\n"; \
		printf "fs.inotify.max_user_watches = 100000\n" | sudo tee -a /etc/sysctl.d/99-sysctl.conf > /dev/null; \
		sudo sysctl --system; \
	else \
		printf "fs.inotify.max_user_watches is already set.\n"; \
	fi

stow: stowrc stowignore

stowrc:
	@printf "==> Linking .stowrc"
	@if [ -e "$(HOME)/.stowrc" ] && [ ! -L "$(HOME)/.stowrc" ]; then \
		printf "ERROR: $(HOME)/.stowrc exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/stow/.stowrc $(HOME)/.stowrc; \
	fi

stowignore:
	@printf "==> Linking .stow-global-ignore"
	@if [ -e "$(HOME)/.stow-global-ignore" ] && [ ! -L "$(HOME)/.stow-global-ignore" ]; then \
		printf "ERROR: $(HOME)/.stow-global-ignore exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/stow/.stow-global-ignore $(HOME)/.stow-global-ignore; \
	fi

git:
	$(STOW) git

vim-base:
	@printf "cloning submodule for vim-infolines\n"
	@git submodule update --init --recursive
	$(STOW) vim-base

vim:
	$(MAKE) vim-base
	$(MKDIR) $(XDG_STATE_HOME)/vim
	$(MKDIR) $(XDG_STATE_HOME)/vim/undodir
	$(MKDIR) $(XDG_STATE_HOME)/vim/backup
	$(MKDIR) $(XDG_STATE_HOME)/vim/swap
	$(MKDIR) $(XDG_DATA_HOME)/vim
	$(STOW) vim

neovim:
	$(MAKE) vim-base
	$(MKDIR) $(XDG_STATE_HOME)/nvim
	$(MKDIR) $(XDG_STATE_HOME)/nvim/undodir
	$(MKDIR) $(XDG_STATE_HOME)/nvim/backup
	$(MKDIR) $(XDG_STATE_HOME)/nvim/swap
	$(STOW) nvim

nvim:
	$(MAKE) neovim

clean:
	$(STOW) -D $(STOW_PACKAGES)

arch-linux:
	$(PKGINSTALL) neovim nodejs npm
	$(PKGINSTALL) zoxide fzf

wayland:
	$(PKGINSTALL) \
		wlr-randr \
		fuzzel \
		dunst \
		swayidle \
		swaylock \
		wl-clipboard \
		cliphist #unsure

xorg:
	$(PKGINSTALL) \
		xclip

hyprland:
	$(PKGINSTALL) \
		hyprland

shbase:
	@printf "shell"
	@$(STOW) sh-base

shbash:
	$(MKDIR) $(XDG_DATA_HOME)/bash
	@$(STOW) sh-bash

shzsh:
	$(MKDIR) $(XDG_DATA_HOME)/zsh
	@$(STOW) sh-zsh


zoxide:
	zoxide add $(HOME)/dotfiles
	zoxide add $(XDG_CONFIG_HOME)
	zoxide add $(HOME)/Downloads
	zoxide add $(HOME)/Dropbox
	zoxide add $(HOME)/Dropbox/shm

navi:
	$(PKGINSTALL) navi fzf
	$(MKDIR) $(XDG_DATA_HOME)/navi/cheats
	$(MKDIR) $(XDG_CONFIG_HOME)/navi

bin:
	$(MKDIR) $(HOME)/.local/bin
	$(STOW) scripts

vifm:
	$(MKDIR) $(XDG_CONFIG_HOME)/vifm
	$(MKDIR) $(XDG_CONFIG_HOME)/vifm/scripts
	$(MKDIR) $(XDG_CONFIG_HOME)/vifm/colors
	$(MKDIR) $(HOME)/src
	@cd "$(HOME)/src" && \
	if [ -d vifm-sixel-preview/.git ]; then \
		printf "Updating vifm-sixel-preview..."; \
		cd vifm-sixel-preview && git pull --ff-only; \
	else \
		printf "Cloning vifm-sixel-preview..."; \
		git clone https://github.com/eylles/vifm-sixel-preview; \
	fi && \
	cd "$(HOME)/src/vifm-sixel-preview" && \
	$(CAT) ./vifm-sixel && \
	printf "\nInstall vifm-sixel-preview? [y/N] " && \
	read inst && case "$$inst" in [yY]) \
		cp --interactive --verbose ./vifm-sixel $(XDG_CONFIG_HOME)/vifm/scripts/vifm-sixel && \
		chmod +x $(XDG_CONFIG_HOME)/vifm/scripts/vifm-sixel ;; \
	esac
	$(STOW) vifm

rust:
	$(MKDIR) $(HOME)/.cargo/bin
	@printf "Setting up rust from https://rustup.rs/..."
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	@. $(HOME)/.cargo/env
	@printf "Installing the latest stable Rust toolchain (rustc, cargo, rustup)"
	@rustup default stable
	@printf "Verifying installation..."
	@rustc --version
	@cargo --version
	@printf "Installing the rust linter (clippy) and code formatter (Rustfmt)"
	@rustup component add clippy rustfmt
	@printf "Installing common cargo tools..."
	@printf "cargo-edit: manage dependencies"
	@printf "cargo-watch: automatically recompile on file changes"
	@printf "cargo-outdated: check outdated dependencies"
	@cargo install cargo-edit cargo-watch cargo-outdated
	@printf "install rust-alalyzer lsp"
	@rustup component add rust-analyzer
	@printf "install lldb and gdb for debugging; gcc for linking?\n"
	@printf "press return to install via pacman/paru or ctl+c to quit\n"
	@read dummy
	$(PKGINSTALL) lldb gdb gcc

go-install:
	@printf "Install go from https://go.dev/dl/"
	@printf "Exit the shell before calling make go-setup"

go-setup:
	@go version
	@printf "Installing go lsp gopls...\n"
	@go install golang.org/x/tools/gopls@latest
	@printf "Installing go debugger delve...\n"
	@go install github.com/go-delve/delve/cmd/dlv@latest
	@printf "Installing goimports...\n"
	@go install golang.org/x/tools/cmd/goimports@latest
	@printf "Installing staticcheck linter...\n"
	@go install honnef.co/go/tools/cmd/staticcheck@latest

fzf:
	$(PKGINSTALL) fzf

hledger:
	$(PKGINSTALL) hledger miller

xdg-dirs:
	$(MKDIR) "$(HOME)/.local/share"
	$(MKDIR) "$(HOME)/.cache"
	$(MKDIR) "$(HOME)/.config"
	$(MKDIR) "$(HOME)/.local/state"

nix-install:
	$(MKDIR) "$(XDG_CONFIG_HOME)/nix"
	@printf "==> Linking ~/.config/nix/nix.conf"
	@if [ -e "$(XDG_CONFIG_HOME)/nix/nix.conf" ] && [ ! -L "$(XDG_CONFIG_HOME)/nix/nix.conf" ]; then \
		printf "ERROR: %(XDG_CONFIG_HOME)/nix/nix.conf exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/nix/.config/nix/nix.conf $(XDG_CONFIG_HOME)/nix/nix.conf; \
	fi
	@printf "==> Installing nix...\n"
	curl --location https://nixos.org/nix/install -o /tmp/nix-install.sh
	@printf "\n==> Showing install script contents:\n\n"
	@$(CAT) /tmp/nix-install.sh
	@printf "\npress enter to continue...\n"
	@read dummy
	@chmod +x /tmp/nix-install.sh
	/bin/sh /tmp/nix-install.sh
	@printf "\n nix will not work unless the shell is restarted. enter to exit.\n"
	@printf "call make nix-profile-install to install the profile.\n"
	@read dummy

nix-profile-install:
	nix profile install '$(HOME)/dotfiles/nix/shm-mac#shm-darwin'

nix-up:
	nix flake update --flake '$(HOME)/dotfiles/nix/shm-mac'
	nix profile upgrade 'nix/shm-mac'

xcode-dev:
	xcode-select --install

filevault:
	fdesetup status
	sudo fdesetup enable --user "$(USER)"
	fdesetup status

nerdfont:
	curl --location --output $(HOME)/Downloads/CommitMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CommitMono.zip
	$(MKDIR) $(HOME)/Downloads/CommitMono
	unzip -o $(HOME)/Downloads/CommitMono.zip -d $(HOME)/Downloads/CommitMono
	if [ "$(OS)" = "macos" ]; then \
		if ls ~/Library/Fonts/CommitMono*Nerd*.*tf >/dev/null 2>&1; then \
			printf "CommitMono Nerd Font is already installed.\n"; \
		else \
			open -a "Font Book" \
		fi \
	else \
		printf "Install step skipped: not on macOS (OS = %s)\n" "$$(OS)"; \
	fi

macos-base:
	$(MAKE) xcode-dev
	$(MAKE) xdg-dirs
	$(MAKE) filevault
	@/bin/bash $(BOOTSTRAP_DIR)/m-enable-touch-id-sudo.sh
	@/bin/bash $(BOOTSTRAP_DIR)/m-set-defaults-preferences.sh
	$(MAKE) nerdfont
	$(MAKE) stow
	# add my user to the developer group
	sudo dscl . append /Groups/_developer GroupMembership $(whoami)

macos-nix:
	$(MAKE) macos-base
	$(MAKE) nix-install

macos-cli:
	$(MAKE) git
	$(MAKE) zoxide
	$(MAKE) shbase
	$(MAKE) shzsh
	$(MAKE) shbash
	$(MAKE) bin
	$(MAKE) vim
	$(MAKE) neovim

homebrew-install:
	@/bin/bash $(HOME)/dotfiles/homebrew/homebrew-install.sh

macos-homebrew:
	$(MAKE) macos-base
	$(MAKE) homebrew-install

todo-txt-install:
	$(MKDIR) $(HOME)/.todo
	$(MKDIR) $(HOME)/.todo/actions
	$(STOW) todo-txt

# macos software installed
# firefox - sign into sync / arkenfox
# ghostty
#keepassxc - change settings to enable browser and ssh access
# hazel
# alfred
# dropbox
#
# Systme settings changed
# hostname
# mouse
#
# rename host and restart
# install xcode tools and check for updates
# github login and keygen
# upload key to github
# do nix
#
# turned off natural scrolling
# turned off rotate
#
# uninstall pages, garage band news etc
# https://www.keka.io/en/
# https://www.appzapper.com/
# https://www.7-zip.org/download.html
# https://www.videolan.org/vlc/
# https://www.hammerspoon.org/
# https://obsidian.md/
# note to exit shell or source the env vars before installing rust and such with nix -- probably easiest to exit
# make sure to sign into icloud and messages
# https://www.busymac.com/busycontacts/
# https://folivora.ai/
# https://www.publicspace.net/ABetterFinderRename/index.html
# https://marked2app.com/
# https://apphousekitchen.com/
# https://github.com/mhaeuser/Battery-Toolkit/releases
# https://www.lynapp.com/
# https://github.com/p0deje/Maccy/releases
# https://github.com/jordanbaird/Ice/releases/
# https://sindresorhus.com/quickgpt
# Dropbox alternative app: https://maestral.app/
# https://sindresorhus.com/velja
# https://www.mowglii.com/itsycal/
# https://github.com/sbarex/SourceCodeSyntaxHighlight
# https://www.moderncsv.com/
# https://sindresorhus.com/battery-indicator
# https://manytricks.com/witch/
# https://www.popclip.app/
# https://www.stclairsoft.com/DefaultFolderX/
# https://cryptomator.org/
# https://github.com/Mortennn/Dozer/releases/
# https://github.com/dwarvesf/hidden/releases/
# https://jacklandrin.github.io/macos%20app/2021/12/01/onlyswitch.html
# https://github.com/jordanbaird/Ice/releases
# https://discord.com/download
#
# FOR OTHER:
# https://sindresorhus.com/scratchpad
#
# Setup firefox addons including violentmonkey
# https://www.mozilla.org/en-US/firefox/channel/desktop/#developer
# https://neovide.dev/
# https://www.barebones.com/products/bbedit/
# POSSIBLE USEFULE UTiLITIES fuzzy searching and image resizingpdf and video optimization
# https://lowtechguys.com/cling/
# https://lowtechguys.com/clop/
# https://www.popclip.app/extensions/
# Popclip Extensions:
# DuckDuckGo
# BBEdit
# TextEdit
# Alfred
# Uppercase
# Lowercase
# Slugify
# Obsidian
# https://daisydiskapp.com/
# https://www.publicspace.net/ABetterFinderRename/index.html
#
# Alfred workflows: https://www.packal.org/
#
# APP STORE:
# duplicate detective
# gemeni 2
# https://www.devontechnologies.com/apps/freeware - Xmenu
# look into wordservice from devontechnologies too
# https://sindresorhus.com/folder-peek
# https://www.gimp.org/downloads/
# https://inkscape.org
# https://github.com/jordanbaird/Ice/releases
# https://skim-app.sourceforge.io/
# https://neovide.dev/
# https://sqlitebrowser.org/dl/
