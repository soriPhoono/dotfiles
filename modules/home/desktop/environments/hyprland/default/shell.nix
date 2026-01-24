{
  lib,
  config,
  nixosConfig,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      programs = {
        caelestia = {
          enable = true;
          systemd.enable = false;
          cli.enable = true;
        };
      };

      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "${nixosConfig.programs.uwsm.package}/bin/uwsm app -t service -s b caelestia-shell"
        ];

        bind = [
          "$mod, A, exec, ${nixosConfig.programs.uwsm.package}/bin/uwsm app caelestia shell drawers toggle launcher"
        ];
      };
    };
  }
