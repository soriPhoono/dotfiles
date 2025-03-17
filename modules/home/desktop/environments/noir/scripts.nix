{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  config = lib.mkIf cfg.enable {
    desktop.programs.hyprland = {
      autostart = let
        bootstrap = pkgs.writeShellApplication {
          name = "bootstrap.sh";

          runtimeInputs = with pkgs; [
            wl-clipboard-rs
            wl-clip-persist

            swww
          ];

          text = ''
            systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

            wl-clip-persist --clipboard both &

            swww-daemon --format xrgb &

            bitwarden --ozone-platform-hint=auto
          '';
        };
      in [
        "${bootstrap}/bin/bootstrap.sh"
      ];

      onReload = let
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
      in [
        "${reload}/bin/reload.sh &"
      ];
    };

    core.impermanence.directories = [
      ".cache/swww"
    ];
  };
}
