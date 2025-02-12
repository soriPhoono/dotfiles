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
        '';
      };

      reload = pkgs.writeShellApplication {
        name = "reload.sh";

        runtimeInputs = with pkgs; [
          wl-clipboard-rs
          wl-clip-persist

          lxqt.lxqt-policykit

          swww
          waybar
        ];

        text = ''
          lxqt-policykit-agent &

          wl-paste --watch cliphist store &
          wl-clip-persist --clipboard both &

          if pgrep waybar; then pkill waybar; fi

          waybar &

          swww restore
        '';
      };
    in {
      exec = [
        "${reload}/bin/reset.sh"
      ];

      exec-once = [
        "${bootstrap}/bin/bootstrap.sh"
      ];
    };
  };
}
