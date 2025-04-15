#!/usr/bin/env bash

paru -Syu --needed --noconfirm \
    zip unzip unrar \
    clang meson valgrind \
    zig zls \
    rustup \
    python \
    go \
    dart \
    jdk-openjdk \
    nodejs npm \
    easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 \
    firefox profile-sync-daemon \
    discord signal-desktop \
    qbittorrent \
    bitwarden joplin-beta thunderbird \
    visual-studio-code-bin element-desktop obsidian \
    obs-studio gimp

systemctl --user enable --now psd.service
