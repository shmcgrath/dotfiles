DOTFILES := $(CURDIR)
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

sudo:
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
		$(LN) $(DOTFILES)/stow/.stowrc $(HOME)/.stowrc
	fi

stowignore:
	@printf "==> Linking .stow-global-ignore"
	@if [ -e "$(HOME)/.stow-global-ignore" ] && [ ! -L "$(HOME)/.stow-global-ignore" ]; then \
		printf "ERROR: $(HOME)/.stow-global-ignore exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/stow/.stow-global-ignore $(HOME)/.stow-global-ignore
	fi

vim-base:
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

shbash:
	$(MKDIR) $(XDG_DATA_HOME)/bash

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
	@printf "install lldb and gdb for debugging; gcc for linking"
	$(PKGINSTALL) lldb gdb gcc


fzf:
	$(PKGINSTALL) fzf

hledger:
	$(PKGINSTALL) hledger miller

xdg-dirs:
	$(MKDIR) "$(HOME)/.local/share"
	$(MKDIR) "$(HOME)/.cache"
	$(MKDIR) "$(HOME)/.config"
	$(MKDIR) "$(HOME)/.local/state"

nix:
	$(MKDIR) "$(XDG_CONFIG_HOME)/nix"
	@printf "==> Linking ~/.config/nix/nix.conf"
	@if [ -e "$(XDG_CONFIG_HOME)/nix/nix.conf" ] && [ ! -L "$(XDG_CONFIG_HOME)/nix/nix.conf" ]; then \
		printf "ERROR: %(XDG_CONFIG_HOME)/nix/nix.conf exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/nix/.config/nix/nix.conf $(XDG_CONFIG_HOME)/nix/nix.conf \
	fi
	sh <(curl -L https://nixos.org/nix/install)

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
# xcode tools things
#
# turned off natural scrolling
# turned off rotate
#
# uninstall pages, garage band news etc
