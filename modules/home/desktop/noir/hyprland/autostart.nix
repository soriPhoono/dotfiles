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

          swww
        ];

        text = ''
          systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

          lxqt-policykit-agent &

          wl-clip-persist --clipboard both &

          swww-daemon --format xrgb &
        '';
      };

      reload = pkgs.writeShellApplication {
        name = "reload.sh";

        runtimeInputs = with pkgs; [
          libnotify

          swww
        ];

        text =
          # Bash
          ''
            if [[ -d ~/Pictures/Wallpapers ]];
            then
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
