{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.bind = [
      "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"
    ];
  };
}
