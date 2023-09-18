#!/bin/bash

packages=(
    "networkmanager",
    "networkmanageer-openvpn",
    "networkmanager-openconnect",
    "ufw",
)

paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1

read -p "Enable NetworkManager advanced features (tor, i2p, dnscrypt proxy)? [Y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    
fi
