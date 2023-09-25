volume_control="pactl"

case "$1" in
"volume")
    case "$2" in
    "up")
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        ;;
    "down")
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        ;;
    "toggle")
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    *) notify-send "Invalid argument: $2" ;;
    esac
    ;;
"mic")
    case "$2" in
    "up")
        pactl set-source-volume @DEFAULT_SOURCE@ +5%
        ;;
    "down")
        pactl set-source-volume @DEFAULT_SOURCE@ -5%
        ;;
    "toggle")
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
    *) notify-send "Invalid argument: $2" ;;
    esac
    ;;
*) notify-send "Invalid argument: $1" ;;
esac
