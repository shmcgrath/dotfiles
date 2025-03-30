DOTFILES := $(CURDIR)
MKDIR := mkdir --parents --verbose
LN := ln --symbolic --verbose --force
LNDIR := ln --symbolic --verbose
PKGINSTALL = doas pacman -S
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

.PHONY: all clean $(STOW_PACKAGES) stow

all: $(STOW_PACKAGES)

$(STOW_PACKAGES):
	@echo "==> Setting up $@"
	@$(MAKE_DIRS)
	@$(STOW) $@



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

vim:
	$(MKDIR) $(CONFIG_DIR)/vim
	$(STOW) vim

clean:
	$(STOW) -D $(STOW_PACKAGES)
