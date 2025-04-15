#!/usr/bin/env bash

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

files=(
    etc/pacman.conf
    etc/paru.conf
)

for file in "${files[@]}"; do
    sudo cp "./src/files/$file" "/$file"
done

paru
