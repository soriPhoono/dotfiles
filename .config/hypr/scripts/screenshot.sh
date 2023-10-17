#!/usr/bin/env bash

source "$HOME/.local/bin/environment.sh"

get_target_directory() {
  test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" &&
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

  echo "${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

CURSOR=

while [ $# -gt 0 ]; do
  key="$1"

  case $key in
  -c|--cursor)
    CURSOR=yes
    shift
    ;;
  *)
    break
    ;;
  esac
done

ACTION=${1:-usage}
SUBJECT=${2:-screen}

notify_ok() {
  notify-send -r 999 -i "$icon_screenshot" "Screenshot copied to clipboard"
}

take_screenshot() {
  local file=$1
  local geom=$2
  local output=$3
  if [ -n "$output" ]; then
    grim ${CURSOR:+-c} -o "$output" "$file" || return 1
  elif [ -z "$geom" ]; then
    grim ${CURSOR:+-c} "$file" || return 1
  else
    grim ${CURSOR:+-c} -g "$geom" "$file" || return 1
  fi
}

if [ "$SUBJECT" = "active" ]; then
  FOCUSED=$(hyprctl activewindow -j)
  GEOM=$(echo "$FOCUSED" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
elif [ "$SUBJECT" = "output" ]; then
  GEOM=""
  OUTPUT=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true)' | jq -r '.name')
elif [ "$SUBJECT" = "area" ]; then
  WORKSPACES="$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')"
  WINDOWS="$(hyprctl clients -j | jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))')"
  GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -b 00000080 -c 00000080)
  if [ -z "$GEOM" ]; then
    exit 1
  fi
fi

if [ "$ACTION" = "copy" ]; then
  take_screenshot - "$GEOM" "$OUTPUT" | wl-copy --type image/png || return 1
  notify_ok
fi
