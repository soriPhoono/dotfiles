#!/usr/bin/env bash

# Language support

# System
# - bash
# - fish

# Desktop
# - c/c++
# - zig
# - rust
# - java

# Server
# - go
# - python

# Mobile
# - android studio

# Web
# - nodejs
# - npm
# - bun
# - deno

paru -Syu

paru -S --needed --noconfirm \
  shellcheck shfmt \
  clang meson ninja valgrind \
  zig zls \
  rustup \
  go go-tools \
  python \
  android-studio \
  nodejs npm bun deno

paru -Syu --needed --noconfirm \
    zip unzip unrar \
    easyeffects calf lsp-plugins-lv2 zam-plugins-lv2 \
    firefox profile-sync-daemon \
    discord signal-desktop grayjay-bin \
    qbittorrent \
    bitwarden joplin-beta thunderbird \
    visual-studio-code-bin element-desktop obsidian \
    obs-studio gimp

systemctl --user enable --now psd.service

rustup default stable
