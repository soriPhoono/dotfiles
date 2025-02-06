{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
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
      workspace = cfg.workspaceRules;

      windowrulev2 =
        [
          # Opacity
          "opacity 0.8, class:(.*)"

          "float, class:(clipse)"
          "size 622 652, class:(clipse)"
        ]
        ++ cfg.windowRules;

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
