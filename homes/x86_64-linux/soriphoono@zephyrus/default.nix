{
  desktop.noir.enable = true;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@144, 0x0, 1"
    ];

    bindl = let
      switchId = "c0b2370";

      monitor = "eDP-1, 1920x1080@144, 0x0, 1";
    in [
      ", switch:on:${switchId}, exec, hyprctl keyword monitor \"eDP-1, disable\""
      ", switch:off:${switchId}, exec, hyprctl keyword monitor \"${monitor}\""
    ];
  };
}
