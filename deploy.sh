#!/usr/bin/env bash
set -e

echo "## Kicking off the NixOS configuration update ##"
echo

echo "Backing up existing configuration..."
sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix_backup 2>/dev/null || true
sudo cp /etc/nixos/home.nix /etc/nixos/home.nix_backup 2>/dev/null || true
sudo cp -R /etc/nixos/conf /etc/nixos/conf_backup 2>/dev/null || true
echo "   Done."
echo


echo "Copying new configuration files to /etc/nixos/..."
sudo cp configuration.nix /etc/nixos/
sudo cp home.nix /etc/nixos/
echo "   Done."
echo

echo "Rebuilding the NixOS system. This may take a few moments..."
sudo nixos-rebuild switch
echo

echo "(Re)Installation completed !!"
