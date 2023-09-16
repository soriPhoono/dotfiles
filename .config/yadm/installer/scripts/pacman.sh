#!/bin/bash

# Set up core pacman requirements for both efficiency and modernization
if [[ -f /etc/pacman.conf.bak ]]; then
    sudo mv /etc/pacman.conf.bak /etc/pacman.conf

    if [[ -f /etc/reflector.conf.bak ]]; then
        sudo mv /etc/reflector.conf.bak /etc/reflector.conf
    fi
fi

# Setup pacman.conf
sudo cp /etc/pacman.conf /etc/pacman.conf.bak                                  # Create pacman.conf backup file
sudo sed -i 's/#Color/Color/' /etc/pacman.conf                                 # Enable colored output
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf # Enable parallel downloads

# Enable multilib repository
sudo sed -i 's/#\[multilib\]/\[multilib\]/' /etc/pacman.conf # Enable multilib
sudo sed -i '/\[multilib\]/!b;n;cInclude = \/etc\/pacman.d\/mirrorlist' /etc/pacman.conf

# Enable chaotic aur repository
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com                                                                                                           # Add chaotic-aur key
sudo pacman-key --lsign-key 3056513887B78AEB                                                                                                                                           # Sign key
sudo pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' # Install keyring and mirrorlist

sudo pacman -Syyu --noconfirm --needed # Update system

# Install paru
sudo pacman -S --noconfirm --needed paru # Install paru

paru -S --noconfirm --needed asp bat devtools

sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf # Enable bottom-up mode

# Configure mirrors for optimization
paru -S --noconfirm --needed reflector rsync                                    # Install reflector and rsync
sudo mv /etc/xdg/reflector/reflector.conf /etc/xdg/reflector/reflector.conf.bak # Create backup

sudo systemctl enable --now reflector.timer # Enable reflector timer
sudo systemctl start reflector.service      # Refresh and rate sync mirrors
