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
          systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

          lxqt-policykit-agent &

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

        text =
          # Bash
          ''
            if pgrep waybar; then pkill waybar; fi

            waybar &

            if [[ -d ~/Pictures/Wallpapers ]];
            then
              if pgrep swww-daemon; then swww kill; fi

              swww-daemon &

              if [ $? -eq 1 ]; then
                random_x=$(echo "scale=2; $RANDOM/32767" | bc)
                random_y=$(echo "scale=2; $RANDOM/32767" | bc)

                swww-daemon --format xrgb &

                find ~/Pictures/Wallpapers/ -type f -exec swww img {} --transition-type "grow" --transition-pos "$random_x,$random_y" --transition-duration 3 \;
              fi

              sleep 0.5

              swww restore
            else
              notify-send "Failed to find wallpapers directory"
            fi
          '';
      };
    in {
      exec = [
        "${reload}/bin/reload.sh &"
      ];

      exec-once = [
        "${bootstrap}/bin/bootstrap.sh"
      ];
    };
  };
}
