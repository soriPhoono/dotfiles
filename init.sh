#!/usr/bin/env bash

echo "Dotfiles -- Sori Phoono"

hostname="$(hostnamectl | grep hostname | awk '{print $3}')"

sh "./src/systems/$hostname/default.sh" $hostname
