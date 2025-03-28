#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

cd ~/.dotfiles

git submodule init && git submodule update

stow .
