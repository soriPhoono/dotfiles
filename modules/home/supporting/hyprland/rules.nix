{
  lib,
  config,
  ...
}: let
  cfg = config.supporting.hyprland;
in {
  options.supporting.hyprland = {
    workspaceRules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Extra workspace rules for the system";

      default = [];
    };

    windowRules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Extra window rules for the applications on the system";

      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      workspace =
        [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ]
        ++ cfg.workspaceRules;

      windowrulev2 =
        [
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ]
        ++ cfg.windowRules;
    };
  };
}
