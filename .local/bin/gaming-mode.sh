monitor_mode=$1

gnome-monitor-config set -LpM DP-1 -m 1920x1080@143.980

if [ "$2" = "--fgc" ]; then
  env DXVK_ASYNC=1 LD_PRELOAD="" gamemoderun gamescope -W 1920 -H 1080 -r 144 --adaptive-sync --mangoapp -fbe -- "${@:3}"
else
  env DXVK_ASYNC=1 LD_PRELOAD="" gamemoderun gamescope -W 1920 -H 1080 -r 144 --adaptive-sync --mangoapp -fbe -- "${@:2}"
fi

case $monitor_mode in
triple)
  gnome-monitor-config set -LM DP-5 -m 1920x1080@165.002 -LpM DP-1 -x 1920 -m 1920x1080@143.980 -LM HDMI-1 -x 3840 -m 1920x1080@74.986
  ;;
double)
  gnome-monitor-config set -LpM DP-1 -m 1920x1080@143.980 -LM HDMI-1 -x 1920 -m 1920x1080@74.986
  ;;
esac
