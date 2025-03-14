{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.hyprland;
in {
  options.desktop.programs.hyprland = let
    mkListOfStr = description:
      lib.mkOption {
        inherit description;
        type = with lib.types; listOf str;

        default = [];
      };
  in {
    enable = lib.mkEnableOption "Enable hyprland wayland compositor";

    environmentVariables = lib.mkOption {
      type = with lib.types; attrsOf str;

      default = {};

      description = "Environment variables for the session compositor";
    };

    extraSettings = lib.mkOption {
      type = with lib.types; attrs;

      default = {};

      description = "Extra hyprland settings";
    };

    autostart = lib.mkOption {
      type = with lib.types; listOf str;

      default = [];

      description = "Commands to run on hyprland startup";
    };

    onReload = lib.mkOption {
      type = with lib.types; listOf str;

      default = [];

      description = "Commands to run on hyprland reload";
    };

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";

      default = "SUPER";
    };

    windowRules = mkListOfStr "Window rules for Hyprland.";

    animations = {
      curves = mkListOfStr "Animation curves for Hyprland.";
      animationRules = mkListOfStr "Animation rules for Hyprland.";
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
      enable = true;

      systemd.variables = ["--all"];

      settings =
        {
          env =
            lib.mapAttrsToList
            (name: value: "${name},${value}")
            cfg.environmentVariables;
        }
        // cfg.extraSettings;

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

      exec-once = cfg.autostart;
      exec = cfg.onReload;

      windowrulev2 = cfg.windowRules;

      bezier = cfg.animations.curves;
      animation = cfg.animations.animationRules;
    };
  };
}
