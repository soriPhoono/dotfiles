#!/usr/bin/env bash

# nm-toggle.sh - Toggle NetworkManager on/off

if [[ "$(nmcli radio wifi)" == "enabled" ]]; then
  nmcli radio wifi off
else
  nmcli radio wifi on
fi

# scripts/nm-toggle.sh
