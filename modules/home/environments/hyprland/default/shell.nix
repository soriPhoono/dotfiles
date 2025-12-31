{
  lib,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      programs.ashell = {
        enable = true;
        systemd.enable = true;
      };
    };
  }
