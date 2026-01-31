{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in
  with lib; {
    options.desktop.environments.hyprland = {
      enable = mkEnableOption "Enable hyprland core config, ENABLE THIS OPTION IN YOUR CONFIG";

      custom = mkEnableOption "Enable recognition for custom hyprland configurations, ENABLE THIS OPTION IN YOUR CONFIG";

      components = mkOption {
        type = types.listOf (types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              description = "Name of the component";
            };
            command = mkOption {
              type = types.str;
              description = "Command to execute";
            };
            type = mkOption {
              type = types.enum ["app" "service"];
              default = "app";
              description = "UWSM execution type";
            };
            background = mkOption {
              type = types.bool;
              default = false;
              description = "Whether to start in background";
            };
            reloadBehavior = mkOption {
              type = types.enum ["ignore" "restart"];
              default = "ignore";
              description = "Whether to restart the component on configuration reload. 'ignore' uses exec-once, 'restart' uses exec.";
            };
          };
        });
        default = [];
        description = "Extra components to start with the Hyprland session via UWSM";
      };

      binds = mkOption {
        type = types.listOf (types.submodule {
          options = {
            mods = mkOption {
              type = types.listOf types.str;
              default = ["$mod"];
              description = "Modifier keys for the bind";
            };
            key = mkOption {
              type = types.str;
              description = "The key to bind";
            };
            dispatcher = mkOption {
              type = types.str;
              description = "Hyprland dispatcher to call";
            };
            params = mkOption {
              type = types.str;
              default = "";
              description = "Parameters for the dispatcher";
            };
            type = mkOption {
              type = types.enum ["bind" "binde" "bindm" "bindl" "bindle" "bindi" "bindt"];
              default = "bind";
              description = "Hyprland bind type";
            };
            description = mkOption {
              type = types.str;
              default = "";
              description = "Description of what this bind does";
            };
          };
        });
        default = [];
        description = "Structured list of keybindings for Hyprland";
      };

      mod = mkOption {
        type = types.str;
        default = "SUPER";
        description = "The modifier key to use for Hyprland bindings";
      };
    };

    config = mkIf cfg.enable {
      desktop.environments.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        settings = let
          # Helper to format a component for uwsm
          mkUWSMApp = c:
            "${pkgs.uwsm}/bin/uwsm app "
            + (
              if c.type == "service"
              then "-t service "
              else ""
            )
            + (
              if c.background
              then "-s b "
              else ""
            )
            + "-- ${c.command}";

          # Split components based on reload behavior
          execOnceComponents = filter (c: c.reloadBehavior == "ignore") cfg.components;
          execComponents = filter (c: c.reloadBehavior == "restart") cfg.components;

          # Format binds into attribute sets per type
          groupedBinds = foldl' (acc: bind: let
            bindStr = "${concatStringsSep " " bind.mods}, ${bind.key}, ${bind.dispatcher}, ${bind.params}";
          in
            acc // {${bind.type} = (acc.${bind.type} or []) ++ [bindStr];}) {}
          cfg.binds;
        in
          {
            "$mod" = cfg.mod;
            exec-once = map mkUWSMApp execOnceComponents;
            exec = map mkUWSMApp execComponents;
          }
          // groupedBinds;
      };
    };
  }
