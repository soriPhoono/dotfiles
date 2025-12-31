{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.managers.hyprland.saphire;
in
  with lib; {
    options.desktop.environments.managers.hyprland.saphire = {
      enable = mkEnableOption "Enable hyprland desktop environment saphire.";
    };

    config = mkIf cfg.enable {
      assertions = [
        {
          assertion = config.desktop.environments.managers.hyprland.configurationName == "saphire";
          message = "Hyprland can only run one configuration at a time, disable all other custom configurations to use saphire.";
        }
      ];

      desktop.environments = {
        display_managers.sddm = mkIf (config.desktop.enable && config.desktop.environment == null) {
          enable = true;
          theme = {
            package = pkgs.catppuccin-sddm.override {
              flavor = "frappe";
              accent = "teal";
              background = ../../../../../assets/wallpapers/beach-path.jpg;
              loginBackground = true;
            };
            name = "catppuccin-frappe-teal";
          };
        };

        managers.hyprland = {
          enable = true;
          configurationName = "saphire";
        };
      };

      home-manager.users =
        builtins.mapAttrs (name: _: {
          environments.hyprland.enable = true;
        })
        config.core.users;
    };
  }
