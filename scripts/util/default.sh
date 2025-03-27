#!/usr/bin/env bash

function install_packages() {
  paru -Syu --needed "$@"
}

source ./scripts/util/logger.sh
