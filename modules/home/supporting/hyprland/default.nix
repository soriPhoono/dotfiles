{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.supporting.hyprland;
in {
  options.supporting.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";
      default = "SUPER";
    };

    extraSettings = lib.mkOption {
      type = lib.types.attrs;
      description = "The extra settings for your desktop";
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];

      settings =
        {
          "$mod" = cfg.modKey;

          bind =
            [
              "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
            ]
            ++ (
              builtins.concatLists (builtins.genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mod, ${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, ${toString i}, movetoworkspacesilent, ${toString ws}"
                  ]
                )
                9)
            );
        }
        // cfg.extraSettings;
    };
  };
}
