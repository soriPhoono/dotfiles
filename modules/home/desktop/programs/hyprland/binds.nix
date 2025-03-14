{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hyprland;
in {
  options.hyprland = {
    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";

      default = "SUPER";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = let
      killScript = pkgs.writeShellApplication {
        name = "killscript.sh";

        runtimeInputs = with pkgs; [
          jq
          xdotool
        ];

        text = ''
          if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
            xdotool getactivewindow windowunmap
          else
            hyprctl dispatch killactive ""
          fi
        '';
      };
    in {
      "$mod" = cfg.modKey;

      bind =
        [
          "$mod, Q, exec, ${killScript}/bin/killscript.sh"

          "$mod, F, togglefloating, "
          "$mod, P, pin, active"
          "$mod, C, centerwindow, "
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
                "$mod, ${toString ws}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString ws}, movetoworkspacesilent, ${toString ws}"
              ]
            )
            9)
        );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, Control_L, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, ALT_L, resizewindow"
      ];
    };
  };
}
