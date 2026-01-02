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

      desktop.environments.managers.hyprland = {
        enable = true;
        configurationName = "saphire";
      };
    };
  }
