#!/usr/bin/env bash

hostname=$1

source ./src/util/default.sh

logger_init

sh ./src/lib/chaotic-aur.sh

info "Deploying configurations"

sudo cp -r ./root/* /

info "Installing packages"

install_packages paru

install_packages --aur pacman-contrib reflector \
  plymouth plymouth-theme-dna-git \
  libpwquality iptables-nft firewalld \
  easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 \
  stow ttf-sourcecodepro-nerd otf-aurulent-nerd \
  bibata-cursor-translucent papirus-icon-theme \
  fish starship btop eza fastfetch nvtop \
  nodejs npm rustup ripgrep direnv less \
  git-delta firefox profile-sync-daemon \
  discord signal-desktop element-desktop \
  bitwarden onlyoffice-bin thunderbird \
  neovim visual-studio-code-bin obsidian \
  gimp inkscape krita tenacity \
  blender tailscale

sudo systemctl enable --now paccache.timer
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now firewalld.service
sudo systemctl enable --now bluetooth.service

systemctl --user enable --now psd.service

if ! grep -q "options plymouth.use-simpledrm splash quiet" /boot/loader/entries/*linux-zen.conf; then
	echo "options plymouth.use-simpledrm splash quiet" | sudo tee -a /boot/loader/entries/*linux-zen.conf
fi

git submodule init && git submodule update

stow -R . || exit

chsh --shell /usr/bin/fish

rustup default stable

read -rp "Install gaming features? [y/N]: " -n 1
echo -e '\n'

if [[ "$REPLY" =~ [yY] ]]; then
  paru -S --needed --noconfirm winetricks protontricks-git protonup gamemode \
    gamescope steam lutris bottles prismlauncher gzdoom \
    obs-studio obs-vkcapture obs-gstreamer gstreamer-vaapi

  if [ "$hostname" = "workstation" ]; then
    mkdir -p ~/.local/bin

    cat <<EOF >~/.local/bin/gaming-mode.sh
#!/usr/bin/env bash

gnome-monitor-config set -LpM DP-1 -m 1920x1080@143.980

if [ "\$2" = "--fgc" ]; then
  env DXVK_ASYNC=1 LD_PRELOAD="" gamemoderun gamescope -W 1920 -H 1080 -r 144 --adaptive-sync --force-grab-cursor -fbe -- "\${@:3}"
else
  env DXVK_ASYNC=1 LD_PRELOAD="" gamemoderun gamescope -W 1920 -H 1080 -r 144 --adaptive-sync -fbe -- "\${@:2}"
fi

gnome-monitor-config set -LpM DP-1 -m 1920x1080@143.980 -LM HDMI-1 -x 1920 -m 1920x1080@74.986
EOF

    chmod +x ~/.local/bin/gaming-mode.sh
  fi
fi
