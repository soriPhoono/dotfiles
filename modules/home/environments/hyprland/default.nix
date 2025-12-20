{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.environments.hyprland;
in
  with lib; {
    options.environments.hyprland = {
      enable = mkEnableOption "Enable hyprland core config, ENABLE THIS OPTION IN YOUR CONFIG";

      custom = mkEnableOption "Enable recognition for custom hyprland configurations, ENABLE THIS OPTION IN YOUR CONFIG";
    };

    config = mkIf cfg.enable {
      home.sessionVariables.NIXOS_OZONE_WL = "1"; # TEST This for compatability with uwsm

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        settings = {
          "$mod" = "SUPER";
          bind =
            [
              "$mod, Return, exec, kitty"
            ]
            ++ (
              # workspaces
              # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
              builtins.concatLists (builtins.genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mod, code:1${toString i}, workspace, ${toString ws}"
                    "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                  ]
                )
                9)
            );
        };
      };

      programs.kitty.enable = true;
    };
  }
