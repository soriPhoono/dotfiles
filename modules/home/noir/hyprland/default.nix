{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.noir;
in {
  config = lib.mkIf cfg.enable {
    supporting.hyprland.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = [
        "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      ];
    };
  };
}
