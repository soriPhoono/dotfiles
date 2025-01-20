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

        bind =
          [
            "$mod, Q, killactive, "

            "$mod, Tab, swapnext, "

            "$mod, F, togglefloating, "
            "$mod, P, pin, active"
            "$mod, C, centerwindow, "

            "$mod CTRL_SHIFT, Up, resizeactive, 0 -10"
            "$mod CTRL_SHIFT, Left, resizeactive, -10 0"
            "$mod CTRL_SHIFT, Right, resizeactive, 10 0"
            "$mod CTRL_SHIFT, Down, resizeactive, 0 10"

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
              in [
                "$mod, ${key}, movefocus, ${direction}"
                "$mod CTRL, ${key}, movewindow, ${direction}"
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
