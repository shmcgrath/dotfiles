#!/usr/bin/env bash

set -euo pipefail

echo "Uninstalling Nix from macOS..."

# Stop and remove nix-daemon if present
if [ -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist ]; then
    echo "Stopping nix-daemon..."
    sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.nix-daemon.plist || true
    echo "Removing nix-daemon.plist..."
    sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist
fi

# Remove system-wide Nix config
if [ -d /etc/nix ]; then
    echo "Removing /etc/nix..."
    sudo rm -rf /etc/nix
fi

# Remove the /nix store
#if [ -d /nix ]; then
    #echo "Removing /nix store..."
    #sudo rm -rf /nix
#fi

#sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
#sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
#sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc

# Remove user-level config and state
echo "Removing user nix config..."
rm -rf "$HOME/.nix-profile" \
       "$HOME/.nix-defexpr" \
       "$HOME/.nix-channels" \
       "$HOME/.config/nixpkgs" \
       "$HOME/.nixpkgs" \
       "$HOME/.config/nix-darwin" \
       "$HOME/.config/home-manager"

# Clean up shell RC files
#echo "Cleaning shell config files..."
#RC_FILES=( "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.zprofile" "$HOME/.zshrc" "$HOME/.profile" )
#for rc in "${RC_FILES[@]}"; do
    #[ -f "$rc" ] || continue
    #cp "$rc" "$rc.bak"
    #sed -i '' '/nix/d' "$rc"
#done

#sudo EDITOR=/usr/bin/vi vifs

echo "Nix uninstalled. Original shell configs backed up with .bak suffix."

echo "You may want to log out and back in or reboot to fully reset your environment."

for i in $(seq 1 10); do
	  sudo dscl . -delete /Users/_nixbld$i || true
done
