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
      ghostty
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"
    ];
  };
}
