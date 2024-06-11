#!/usr/bin/env bash

if [[ "$1" == "up" ]]; then
  if [[ $(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@) + 5 -ge 100 ]]; then
    ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
  else
    ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ +5%
  fi
elif [[ "$1" == "down" ]]; then
  ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%
fi
