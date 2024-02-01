#!/usr/bin/env bash

# This script will setup the environment to run the installer script,
# by ensuring all the required packages and dependencies are installed.

# Check if the script is being run as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run this script as root"
    exit 1
fi

dependencies=(
    'python3'

)

nix-shell --command "python $(pwd)/installer/src/main.py" \
    --packages "${dependencies[*]}" \
