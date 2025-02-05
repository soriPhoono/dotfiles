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
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];

      settings = {
        "$mod" = cfg.modKey;

        general = {
          border_size = 3;

          snap = {
            enabled = true;
            border_overlap = true;
          };
        };

        decoration.rounding = 5;

        bind =
          [
            "$mod, Q, killactive, "

            "$mod, F, togglefloating, "
            "$mod, P, pin, active"
            "$mod, C, centerwindow, "

            "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
          ]
          ++ (builtins.concatLists (builtins.genList (
              i: let
                directions = [
                  "Up"
                  "Left"
                  "Right"
                  "Down"
                ];

                key = builtins.elemAt directions i;
                direction = lib.toLower (lib.substring 0 1 key);

                resizeParams =
                  if direction == "u"
                  then "0 -10"
                  else if direction == "l"
                  then "-10 0"
                  else if direction == "r"
                  then "10 0"
                  else "0 10";
              in [
                "$mod, ${key}, movefocus, ${direction}"
                "$mod CTRL, ${key}, movewindow, ${direction}"
                "$mod CTRL_SHIFT, ${key}, resizeactive, ${resizeParams}"
              ]
            )
            4))
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
      };
    };
  };
}
