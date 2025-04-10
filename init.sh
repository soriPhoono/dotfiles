#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

sh ./src/systems/"$(hostnamectl | grep hostname | awk '{print $3}')"/default.sh

git submodule init && git submodule update

paru -S --needed --noconfirm stow

stow -R . || exit

paru -S --needed --noconfirm \
  ttf-sourcecodepro-nerd otf-aurulent-nerd \
  bibata-cursor-translucent papirus-icon-theme \
  fish starship btop eza fastfetch nvtop \
  nodejs npm rustup ripgrep direnv less \
  git-delta \
  firefox profile-sync-daemon \
  discord signal-desktop element-desktop \
  bitwarden onlyoffice-bin thunderbird \
  neovim visual-studio-code-bin obsidian

chsh --shell /usr/bin/fish

rustup default stable

systemctl --user enable --now psd.service

read -rp "Install gaming features? [y/N]: " -n 1
echo -e '\n'

if [[ "$REPLY" =~ [yY] ]]; then
  hostname="$(hostnamectl | grep hostname | awk '{print $3}')"

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
