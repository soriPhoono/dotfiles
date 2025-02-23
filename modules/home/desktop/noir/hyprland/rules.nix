{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        # Opacity
        "opacity 0.8, class:(.*)"

        "opacity 1, title:(.* - YouTube —.*)"

        "opacity 1, class:(gamescope)"
        "float, class:(gamescope)"

        "float,class:^(nm-applet)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(pavucontrol)$"
      ];

      bezier = [
        "ease-in-out, .42, 0, .58, 1"
      ];

      animation = [
        "windows, 1, 5, ease-in-out, slide"
        "fade, 1, 5, ease-in-out"
      ];

      env = [
        "NIXOS_OZONE_WL,1"

        "GDK_BACKEND,wayland,x11,*"

        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
    };
  };
}
