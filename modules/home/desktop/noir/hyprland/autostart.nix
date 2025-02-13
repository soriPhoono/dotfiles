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
          lxqt.lxqt-policykit

          wl-clipboard-rs
          wl-clip-persist
        ];

        text = ''
          lxqt-policykit-agent &

          wl-paste --watch cliphist store &
          wl-clip-persist --clipboard both &
        '';
      };

      reload = pkgs.writeShellApplication {
        name = "reload.sh";

        runtimeInputs = with pkgs; [
          libnotify

          bc

          waybar
          swww
        ];

        text = ''
          sleep 1

          if [[ -d ~/Pictures/Wallpapers ]];
          then
            swww query
            if [ $? -eq 1 ]; then
              random_x=$(echo "scale=2; $RANDOM/32767" | bc)
              random_y=$(echo "scale=2; $RANDOM/32767" | bc)

              swww-daemon --format xrgb &

              find ~/Pictures/Wallpapers/ -type f -exec swww img {} --transition-type "grow" --transition-pos "$random_x,$random_y" --transition-duration 3 \;
            fi
          else
            notify-send "Failed to find wallpapers directory"
          fi

          if pgrep waybar; then pkill waybar; fi

          waybar &
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
