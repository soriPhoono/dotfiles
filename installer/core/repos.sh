#!/usr/bin/env bash

# Installation functions for optional repositories for pacman and paru

function configure_repos() {
    source "$ROOT_DIR/core/util.sh"

    PACMAN_MODIFIED=false
    MULTILIB_ENABLED=false

    print_header "pacman repositories"

    confirm "Configure multilib repository?" "n"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
        sudo sed -i '/\[multilib\]/!b;n;cInclude = \/etc\/pacman.d\/mirrorlist' /etc/pacman.conf

        PACMAN_MODIFIED=true
        MULTILIB_ENABLED=true
    fi

    confirm "Configure chaotic-aur repository?" "y"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com >/dev/null
        sudo pacman-key --lsign-key 3056513887B78AEB >/dev/null
        sudo pacman --noconfirm --needed -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' >/dev/null
        sudo sh -c "echo -e '[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"

        PACMAN_MODIFIED=true
    fi

    if [[ $PACMAN_MODIFIED == true ]]; then
        update
    fi

    print_footer "pacman repositories"

    # If multilib is enabled, return 1, otherwise return 0
    if [[ $MULTILIB_ENABLED == true ]]; then
        return 1
    else
        return 0
    fi
}
