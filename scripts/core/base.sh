#!/usr/bin/env bash

# Imports
source ./scripts/util/default.sh

# Install chaotic AUR

info "Installing Chaotic-AUR keys"

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

info "Installing Chaotic-AUR packages and mirror"

sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

sudo cp -r ./scripts/root/* /

info "Installing paru and configuring pacman"

sudo pacman -Syu --needed paru pacman-contrib reflector rsync

sudo systemctl enable --now paccache.timer
sudo systemctl enable --now reflector.timer

# Install security systems

info "Hardening system"

info "Configuring password security"

install_packages libpwquality

info "Installing cpu microcode"

case $(grep vendor_id /proc/cpuinfo | awk 'NR==1 {print $3}') in
"GenuineIntel") install_packages intel-ucode ;;
"AuthenticAMD") install_packages amd-ucode ;;
esac

info "Locking root account"

sudo passwd --lock root

# TODO: Check out https://wiki.archlinux.org/title/Security#Sandboxing_applications

info "Setting up firewall"

install_packages firewalld

sudo systemctl enable --now firewalld.service

# Install plymouth boot screen

info "Installing plymouth bootup sequence"

install_packages plymouth plymouth-theme-dna-git dracut

sudo dracut --force

if paru -Q | grep -q mkinitcpio; then
  paru -R mkinitcpio
fi

if grep -q "options plymouth.use-simpledrm splash quiet" /boot/loader/entries/*linux-zen.conf; then
  echo "options plymouth.use-simpledrm splash quiet" | tee -a test.txt
fi

# Installing fonts

install_packages ttf-sourcecodepro-nerd otf-aurulent-nerd

# Configure bluetooth

sudo systemctl enable --now bluetooth.service

# Install tailscale

install_packages tailscale

sudo systemctl enable --now tailscaled

sudo tailscale up
