{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprland = {
      windowRules = [
        # Opacity
        "opacity 0.8, class:(.*)"

        "opacity 1, title:(.* - YouTube —.*)"

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

        "opacity 1, class:(gamescope)"
        "float, class:(gamescope)"
        "workspace 1, class:(gamescope)"
      ];
    };
  };
}
