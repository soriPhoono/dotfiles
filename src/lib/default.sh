#!/usr/bin/env bash

sudo cp -r ./root/* /

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
