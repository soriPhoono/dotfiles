#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

cd ~/.dotfiles || exit

git submodule init && git submodule update

paru -S --needed --noconfirm stow

stow .

paru -S --needed --noconfirm fish starship btop \
  eza fastfetch zip unzip unrar nvtop bc yazi \
  nodejs npm rustup ripgrep zellij neovim \
  visual-studio-code-bin onlyoffice-bin \
  bitwarden firefox profile-sync-daemon thunderbird \
  obsidian discord signal-desktop element-desktop \
  winetricks protontricks-git protonup gamemode \
  gamescope steam lutris bottles prismlauncher gzdoom \
  obs-studio obs-vkcapture obs-gstreamer gstreamer-vaapi

chsh --shell /usr/bin/fish

rustup default stable

systemctl --user enable --now psd.service
