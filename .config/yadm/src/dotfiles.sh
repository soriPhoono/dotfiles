#!/usr/bin/env bash

sudo paru -Syu --needed --noconfirm \
    zip unzip unrar \
    easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 \
    firefox profile-sync-daemon \
    discord signal-desktop \
    qbittorrent \
    bitwarden joplin-desktop thunderbird \
    visual-studio-code-bin element-desktop obsidian \
    obs-studio gimp tenacity davinci-resolve

systemctl --user enable --now psd.service
