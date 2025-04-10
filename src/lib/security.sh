#!/usr/bin/env bash

source ./src/util/default.sh

info "Hardening system"

# TODO: Check out https://wiki.archlinux.org/title/Security#Sandboxing_applications

install_packages libpwquality iptables-nft firewalld

sudo systemctl enable --now firewalld.service
