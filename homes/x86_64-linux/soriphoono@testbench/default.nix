{
  desktop.environments.noir.enable = true;

  userapps.enable = true;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1366x768@60, 0x0, 1"
    ];

    bindl = let
      switchId = "1cda62c0";

      monitor = "eDP-1, 1366x768@60, 0x0, 1";
    in [
      ", switch:on:${switchId}, exec, hyprctl keyword monitor \"eDP-1, disable\""
      ", switch:off:${switchId}, exec, hyprctl keyword monitor \"${monitor}\""
    ];
  };
}
