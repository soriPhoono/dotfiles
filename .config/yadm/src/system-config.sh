#!/usr/bin/env bash

files=(
  boot/loader/entries/linux-zen.conf
  boot/loader/entries/linux-zen-fallback.conf

  etc/pam.d/passwd
  etc/pam.d/system-login
  etc/plymouth/plymouthd.conf
  etc/ssh/sshd_config.d/20-deny-root.conf
  etc/ssh/sshd_config.d/20-force-publickey.conf
  etc/sudoers.d/10-wheel
  etc/mkinitcpio.conf
)

for file in "${files[@]}"; do
  sudo cp "./src/files/$file" "/$file"
done

sudo pacman -Syu --needed --noconfirm paru
paru -S --needed --noconfirm \
  pacman-contrib reflector \
  plymouth plymouth-theme-dna-git \
  libpwquality firewalld tailscale \
  gnome-shell-extension-dash-to-dock \
  ttf-sourcecodepro-nerd otf-aurulent-nerd \
  bibata-cursor-translucent papirus-icon-theme \
  fish starship fastfetch direnv eza bat fd fzf \
  ripgrep git-delta less btop nvtop

sudo systemctl enable --now paccache.timer
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now firewalld.service
sudo systemctl enable --now tailscaled.service
sudo systemctl enable --now bluetooth.service

sudo mkinitcpio -P

chsh -s /usr/bin/fish
