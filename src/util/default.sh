#!/usr/bin/env bash

source ./src/util/logger.sh

function install_packages() {
	if [ "$1" = "--aur" ]; then
		paru -S --needed "${@:2}"

		if [ $? -eq 1 ]; then
			err "Failed to install packages" + "${@:2}"

			exit 1
		fi
	else
		sudo pacman -S --needed "${@:1}"

		if [ $? -eq 1 ]; then
			err "Failed to install packages" + "${@:1}"
		fi
	fi
}
