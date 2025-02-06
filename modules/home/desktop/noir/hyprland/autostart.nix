{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = let
      bootstrap = pkgs.writeShellApplication {
        name = "bootstrap.sh";

        runtimeInputs = with pkgs; [
          wl-clipboard-rs
          cliphist

          swww
        ];

        text = ''
          wallpapers=$(command ls ~/Pictures/Wallpapers/)

          wl-paste --watch cliphist store &

          swww-daemon &

          for wallpaper in $wallpapers; do swww img "$wallpaper"; done
        '';
      };
    in {
      exec-once = [
        "${bootstrap}/bin/bootstrap.sh"
      ];
    };
  };
}
