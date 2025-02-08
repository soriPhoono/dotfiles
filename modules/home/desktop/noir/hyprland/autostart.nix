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
          wl-clip-persist
          cliphist

          gammastep

          swww
        ];

        text = ''
          wallpapers=$(command ls ~/Pictures/Wallpapers/)

          wl-paste --watch cliphist store &
          wl-clip-persist --clipboard regular &

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
