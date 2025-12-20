{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in
  with lib; {
    config =
      mkIf (!config.environments.hyprland.custom) {
        environments.hyprland.enable = true;
      };
  }
