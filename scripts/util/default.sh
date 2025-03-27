#!/usr/bin/env bash

source ./scripts/util/logger.sh

function install_packages() {
  paru -S --noconfirm --needed "$@"

  if [ $? -eq 1 ]; then
    err "Failed to install packages" + "$@"

    exit 1
  fi
}
