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
    };
  };
}
