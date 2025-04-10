#!/usr/bin/env bash

source ./src/util/default.sh

# Install controller drivers

# Xbox

info "Installing XBOX controller drivers"

install_packages linux-zen-headers xpadneo-dkms
