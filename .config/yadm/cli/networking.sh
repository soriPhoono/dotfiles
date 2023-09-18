#!/bin/bash

packages=(
    "networkmanager",
    "networkmanageer-openvpn",
    "networkmanager-openconnect",
    "ufw",
)

paru -S --noconfirm --needed "${packages[@]}" >>/dev/null 2>&1


