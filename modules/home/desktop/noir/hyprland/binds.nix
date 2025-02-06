{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";

      default = "SUPER";
    };

    switchId = lib.mkOption {
      type = lib.types.str;
      description = "The id for the laptop switch if applicable";

      default = null;
    };

    extraBinds = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "The extra binds to inject into hyprland's config";

      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      "$mod" = cfg.modKey;

      bind = let
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
      in
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
                "$mod, ${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, ${toString i}, movetoworkspacesilent, ${toString ws}"
              ]
            )
            9)
        )
        ++ cfg.extraBinds;

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, Control_L, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, ALT_L, resizewindow"
      ];

      bindl = let
        monitor = lib.elemAt cfg.monitors 0;
      in
        lib.mkIf (cfg.switchId != null) [
          ", switch:on:${cfg.switchId}, exec, hyprctl keyword monitor \"eDP-1, disable\""
          ", switch:off:${cfg.switchId}, exec, hyprctl keyword monitor \"${monitor.name}, ${monitor.resolution}, ${monitor.position}, ${toString monitor.scale}\""
        ];
    };
  };
}
