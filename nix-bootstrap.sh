#!/usr/bin/env bash
# post-install.sh - script to run post NixOS installation

set -euo pipefail

REPO_DIR="/tmp/nix-bootstrap"
DOTFILES_REPO="https://github.com/0lswitcher/dotfiles.git"
NIXFILES_REPO="https://github.com/0lswitcher/nixfiles.git"
NIXOS_DIR="/etc/nixos"

prompt() {
    local message="$1"
    shift
    local options=("$@")
    local choice
    
    echo "$message" >&2  # send prompt to stderr so it doesn't interfere with return value
    select choice in "${options[@]}"; do
        if [[ -n "$choice" ]]; then
            echo "$choice"  # goes to stdout and will be captured
            return 0
        else
            echo "Invalid choice. Please try again." >&2
        fi
    done
}

clone_or_update_repo() {
    local repo_url="$1"
    local target_dir="$2"

    if [ -d "$target_dir/.git" ]; then
        echo "Updating $target_dir..."
        git -C "$target_dir" pull --ff-only
    else
        echo "Cloning $repo_url..."
        git clone "$repo_url" "$target_dir"
    fi
}

# online / offline
if ping -c 1 github.com &>/dev/null; then
    MODE=$(prompt "Choose installation mode:" "Online" "Offline")
else
    echo "No internet connection detected. Defaulting to Offline mode."
    MODE="Offline"
fi

echo "Selected mode: $MODE"  # Debug output

if [ "$MODE" = "Online" ]; then
    echo "Running in Online mode - cloning repositories..."
    clone_or_update_repo "$DOTFILES_REPO" "$REPO_DIR/dotfiles"
    clone_or_update_repo "$NIXFILES_REPO" "$REPO_DIR/nixfiles"
else
    echo "Running in Offline mode..."
    read -rp "Enter the path where offline repos are located: " OFFLINE_PATH
    REPO_DIR="$OFFLINE_PATH"
fi

# install type
INSTALL_TYPE=$(prompt "Select installation type:" "Server" "Minimal" "Full")
echo "Selected installation type: $INSTALL_TYPE"  # Debug output

# hardware type
HW_TYPE=$(prompt "Select hardware:" "Desktop" "Laptop")
echo "Selected hardware type: $HW_TYPE"  # Debug output

# extract stateVersion from existing configuration.nix before overwriting it
echo "Extracting system.stateVersion from existing configuration..."
NIXOS_VER=$(grep "system.stateVersion" "$NIXOS_DIR/configuration.nix" 2>/dev/null || true)

# write configuration.nix
echo "Generating configuration.nix with imports..."
sudo cp "$REPO_DIR/nixfiles/base.nix" "$NIXOS_DIR/base.nix"
sudo cp "$REPO_DIR/nixfiles/roles/${INSTALL_TYPE,,}.nix" "$NIXOS_DIR/role.nix"

# create configuration.nix dynamically
sudo tee "$NIXOS_DIR/configuration.nix" > /dev/null <<EOF
{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./role.nix
    ./hardware-configuration.nix
  ];

EOF

# append configuration.nix w/ nixos ver. extracted from original file
if [[ -n "$NIXOS_VER" ]]; then
    echo "Adding system.stateVersion: $NIXOS_VER"
    echo "  $NIXOS_VER" | sudo tee -a "$NIXOS_DIR/configuration.nix" > /dev/null
    echo "}" | sudo tee -a "$NIXOS_DIR/configuration.nix" > /dev/null
else
    echo "Warning: Could not find system.stateVersion in original configuration.nix"
    echo "You may need to add it manually or run nixos-generate-config first"
fi

# apply dotfiles
echo "Applying dotfiles for $HW_TYPE..."
USER_HOME="/home/$USER"
cp -r "$REPO_DIR/dotfiles/dots/." "$HOME/.config/"

if [ "$HW_TYPE" = "Laptop" ]; then
    rm -rf "$HOME/.config/waybar/"
    cp -r "$HOME/.config/laptop-specific/waybar/" "$HOME/.config/"
    rm -rf "$HOME/.config/laptop-specific/"
fi

echo "Dotfiles successfully applied."
chown -R "$USER:$(id -gn "$USER")" "$HOME/.config/"
echo "Permissions granted for dotfile usage."

# rebuild system
echo "Rebuilding NixOS..."
sudo nixos-rebuild switch

# exit message
echo "Bootstrap complete. Reboot recommended. Don't forget to run passwd!"
echo " ~ If you're using an Nvidia GPU, take a look at base.nix before doing so-and do research, since Nvidia GPUs + Linux + Hyprland = Hell"

if [ "$INSTALL_TYPE" = "Full" ]; then
    echo "Don't forget to add 'docker' to extraGroups in base.nix!"
else
    echo "Don't forget to add 'docker' to extraGroups in base.nix if you decide to enable it!"
fi

echo "  Enjoy :) "


