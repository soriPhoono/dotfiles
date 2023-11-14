#!/bin/bash

# Setup repositories for packages

read -p "Configure multilib repository? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Setup multilib repository
	sudo sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
	sudo sed -i '/\[multilib\]/!b;n;cInclude = \/etc\/pacman.d\/mirrorlist' /etc/pacman.conf
	echo "Setup multilib repository"
fi

# Setup chaotic-aur repository
read -p "Configure chaotic-aur repository? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com >/dev/null
	sudo pacman-key --lsign-key 3056513887B78AEB >/dev/null
	sudo pacman --noconfirm --needed -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' >/dev/null
	echo -e "[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
	echo "Setup chaotic-aur repository"
fi
