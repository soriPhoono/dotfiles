{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland.default;
in
  with lib; {
    imports = [
      ./librewolf.nix
    ];

    config = mkIf cfg.enable {
      userapps = {
        terminal.kitty.enable = true;
      };

      wayland.windowManager.hyprland.settings.bind = [
        "$mod, Return, exec, ${pkgs.uwsm}/bin/uwsm app ${pkgs.kitty}/bin/kitty"

        "$mod, Escape, exec, ${pkgs.uwsm}/bin/uwsm stop"
      ];
    };
  }
