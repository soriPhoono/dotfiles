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
        "workspace 1, class:(gamescope)"

        "float,class:^(nm-applet)$"
        "size 80% 80%, class:^(nm-applet)$"
        "center, class:^(nm-applet)$"

        "float,class:^(nm-connection-editor)$"
        "size 80% 80%, class:^(nm-connection-editor)$"
        "center, class:^(nm-connection-editor)$"

        "float,class:^(pavucontrol)$"
        "size 80% 80%, class:^(pavucontrol)$"
        "center, class:^(pavucontrol)$"

        "float,class:^(blueberry.py)$"
        "size, class:^(blueberry.py)$"
        "center, class:^(blueberry.py)$"
      ];

      workspace = [
        "1, default:true"
        "4, default:true"
        "7, default:true"
      ];

      bezier = [
        "ease-in-out, .42, 0, .58, 1"
      ];

      animation = [
        "windows, 1, 5, ease-in-out, slide"
        "fade, 1, 5, ease-in-out"
      ];
    };
  };
}
