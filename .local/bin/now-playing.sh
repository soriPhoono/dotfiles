#!/usr/bin/env bash

notify-send "$(playerctl metadata title) - $(playerctl metadata artist)"
