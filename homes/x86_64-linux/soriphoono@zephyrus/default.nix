{
  desktop.noir.enable = true;

  userapps.enable = true;

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 1920x1080@144, 0x0, 1.5"
    ];

    bindl = let
      switchId = "3f5c7100";

      monitor = "eDP-1, 1920x1080@144, 0x0, 1.5";
    in [
      ", switch:on:${switchId}, exec, hyprctl keyword monitor \"eDP-1, disable\""
      ", switch:off:${switchId}, exec, hyprctl keyword monitor \"${monitor}\""
    ];
  };
}
