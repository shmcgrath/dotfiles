DOTFILES := $(CURDIR)
MKDIR := mkdir --parents --verbose
LN := ln --symbolic --verbose --force
LNDIR := ln --symbolic --verbose
PKGINSTALL = sudo pacman --sync --needed
#PKGINSTALL = doas pacman --noconfirm -S
STOW := stow --target=$(HOME)

#by using ‘sudo -E make’ or ‘sudo -Es’ before running make, would source your env and make it available for sudoer.
# Stow packages
STOW_PACKAGES := nvim vim zsh tmux git

# Find subdirs and make them under $HOME
MAKE_DIRS = cd $@ && \
	find . -type d -print | sed 's|^\./||' | while IFS= read -r dir; do \
		[ -n "$$dir" ] && $(MKDIR) "$$HOME/$$dir"; \
	done

.PHONY: all clean $(STOW_PACKAGES) stow aur pacman wayland xorg hyprland shellbase bash navi zoxide bin rust neovim

all: $(STOW_PACKAGES)

$(STOW_PACKAGES):
	@echo "==> Setting up $@"
	@$(MAKE_DIRS)
	@$(STOW) $@

pacman:
	$(MKDIR) $(HOME)/.config/pacman

sudo:
	$(PKGINSTALL) doas
	@echo "configure doas"
	@echo "configure sudo"
	@echo "doas visudo"
	@echo "uncomment Defaults targetpw"
	@echo "uncomment ALL ALL = (ALL:ALL) ALL"
	@echo "replace the first all with username allowed to sudo"

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


stow: stowrc stowignore

stowrc:
	@echo "==> Linking .stowrc"
	@if [ -e "$(HOME)/.stowrc" ] && [ ! -L "$(HOME)/.stowrc" ]; then \
		echo "ERROR: $(HOME)/.stowrc exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/stow/.stowrc $(HOME)/.stowrc
	fi

stowignore:
	@echo "==> Linking .stow-global-ignore"
	@if [ -e "$(HOME)/.stow-global-ignore" ] && [ ! -L "$(HOME)/.stow-global-ignore" ]; then \
		echo "ERROR: $(HOME)/.stow-global-ignore exists and is not a symlink. Refusing to overwrite."; \
		exit 1; \
	else \
		$(LN) $(DOTFILES)/stow/.stow-global-ignore $(HOME)/.stow-global-ignore
	fi

#vim:
	#$(MKDIR) $(CONFIG_DIR)/vim
	#$(STOW) vim

clean:
	$(STOW) -D $(STOW_PACKAGES)

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
	$(PKGINSTALL)

shbase:
	@echo "shell"

shbash:
	$(MKDIR) $XDG_DATA_HOME/bash

zoxide:
	$(PKGINSTALL) zoxide fzf
	@zoxide add $(HOME)/dotfiles
	@zoxide add $(XDG_CONFIG_HOME)
	@zoxide add $(HOME)/Downloads
	@zoxide add $(HOME)/Dropbox
	@zoxide add $(HOME)/Dropbox/shm

navi:
	$(PKGINSTALL) navi fzf
	$(MKDIR) $(XDG_DATA_HOME)/navi/cheats
	$(MKDIR) $(XDG_CONFIG_HOME)/navi

bin:
	$(MKDIR) $(HOME)/.local/bin

rust:
	$(MKDIR) $(HOME)/.cargo/bin
	@echo "Setting up rust from https://rustup.rs/..."
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	@echo "Installing the latest stable Rust toolchain (rustc, cargo, rustup)"
	@rustup default stable
	@echo "Verifying installation..."
	@rustc --version
	@cargo --version
	@echo "Installing the rust linter (clippy) and code formatter (Rustfmt)"
	@rustup component add clippy rustfmt
	@echo "Installing common cargo tools..."
	@echo "cargo-edit: manage dependencies"
	@echo "cargo-watch: automatically recompile on file changes"
	@echo "cargo-outdated: check outdated dependencies"
	@cargo install cargo-edit cargo-watch cargo-outdated
	@echo "install rust-alalyzer lsp"
	@rustup component add rust-analyzer
	@echo "install lldb and gdb for debugging; gcc for linking"
	$(PKGINSTALL) lldb gdb gcc

neovim:
	$(PKGINSTALL) neovim nodejs npm stylua
