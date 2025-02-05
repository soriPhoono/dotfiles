{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hyprland.soriphoono;
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

          ${builtins.concatStringsSep "\n" (lib.mapAttrsToList (name: val:
            if val == "regular"
            then "swww img ../../../../assets/wallpapers/${name}"
            else "") (builtins.readDir ../../../../assets/wallpapers))}
        '';
      };
    in {
      exec-once = [
        "${wallpaperScript}/bin/wallpaper.sh"
      ];
    };
  };
}
