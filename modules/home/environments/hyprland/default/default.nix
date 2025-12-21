{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in
  with lib; {
    config = mkIf (config.environments.hyprland.enable && !config.environments.hyprland.custom) {
      programs = {
        kitty.enable = true;
        firefox.enable = true;
      };

      wayland.windowManager.hyprland.settings.bind = [
        "$mod, Return, exec, kitty"
        "$mod, B, exec, firefox"
        "$mod, Escape, exec, uwsm stop"
      ];
    };
  }
