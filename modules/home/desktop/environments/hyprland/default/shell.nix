{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in {
  config = lib.mkIf (cfg.enable && cfg.caelestia.enable) {
    programs.caelestia = {
      inherit (cfg.caelestia) settings;
      enable = true;
      systemd.enable = false;
      cli.enable = true;
    };

    desktop.environments.hyprland.binds = [
      {
        key = "A";
        dispatcher = "exec";
        params = "${pkgs.uwsm}/bin/uwsm app -- caelestia shell drawers toggle launcher";
      }
    ];
  };
}
