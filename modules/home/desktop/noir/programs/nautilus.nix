{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
      file-roller
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"
    ];
  };
}
