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
          libnotify

          swww
          waybar
        ];

        text = ''
          sleep 1

          if pgrep swww-daemon; then swww kill; fi

          swww-daemon &

          if [[ -d ~/Pictures/Wallpapers ]];
          then
            find ~/Pictures/Wallpapers/ -type f -exec swww img {} \;
          else
            notify-send "Failed to find wallpapers directory"
          fi

          if pgrep waybar; then pkill waybar; fi

          waybar &
        '';
      };
    in {
      exec = [
        "${bootstrap}/bin/bootstrap.sh"
      ];

      exec-once = [
        "${pkgs.wl-clipboard-rs}/bin/wl-paste --watch cliphist store &"
        "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both &"
      ];
    };
  };
}
