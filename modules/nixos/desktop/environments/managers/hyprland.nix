{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.desktop.environments.managers.hyprland;
in
  with lib; {
    options.desktop.environments.managers.hyprland = {
      enable = mkEnableOption "Enable hyprland desktop environment base.";
    };

    config = mkIf cfg.enable {
      desktop.environments = {
        uwsm.enable = true;
      };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      home-manager.users =
        builtins.mapAttrs (name: _: {
          environments.hyprland.enable = true;
        })
        config.core.users;
    };
  }
