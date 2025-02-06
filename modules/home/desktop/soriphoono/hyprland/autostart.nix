{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.soriphoono;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = let
      wallpaperScript = pkgs.writeShellApplication {
        name = "wallpaper.sh";

        runtimeInputs = with pkgs; [
          swww
        ];

        text = ''
          sleep 1

          swww-daemon &

          wallpapers=$(command ls ~/Pictures/Wallpapers/)

          for wallpaper in $wallpapers; do swww img "$wallpaper"; done
        '';
      };
    in {
      exec-once = [
        "${wallpaperScript}/bin/wallpaper.sh"

        "${pkgs.clipse}/bin/clipse -listen"
      ];
    };
  };
}
