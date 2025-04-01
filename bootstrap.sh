#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

cd ~/.dotfiles || exit

mkdir -p ~/.local/bin

hostname="$(hostnamectl | grep hostname | awk '{print $3}')"

if [ "$hostname" = "workstation" ]; then
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

git submodule init && git submodule update

paru -S --needed --noconfirm stow

stow .

paru -S --needed --noconfirm fish starship btop \
  eza fastfetch nvtop nodejs npm rustup ripgrep neovim \
  visual-studio-code-bin onlyoffice-bin \
  bitwarden firefox profile-sync-daemon thunderbird \
  obsidian discord signal-desktop element-desktop

if [ "$hostname" = "workstation" ]; then
  paru -S --needed --noconfirm winetricks protontricks-git protonup gamemode \
    gamescope steam lutris bottles prismlauncher gzdoom \
    obs-studio obs-vkcapture obs-gstreamer gstreamer-vaapi
fi

chsh --shell /usr/bin/fish

rustup default stable

systemctl --user enable --now psd.service
