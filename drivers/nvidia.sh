#!/usr/bin/env bash

# Imports
source ./util/default.sh

sudo mkdir -p /etc/pacman.d/hooks/
sudo cp ./drivers/root/etc/pacman.d/hooks/nvidia.hook /etc/pacman.d/hooks/
