#!/usr/bin/env bash

source ./src/util/default.sh

info "Installing plymouth bootup sequence"

install_packages --aur plymouth plymouth-theme-dna-git

if ! grep -q "options plymouth.use-simpledrm splash quiet" /boot/loader/entries/*linux-zen.conf; then
	echo "options plymouth.use-simpledrm splash quiet" | sudo tee -a /boot/loader/entries/*linux-zen.conf
fi
