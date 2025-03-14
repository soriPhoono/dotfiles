{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  imports = [
    ./hyprland/binds.nix
    ./hyprland/rules.nix
  ];

  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      programs = {
        fuzzel.enable = true;
        hyprlock.enable = true;
        nautilus.enable = true;
        waybar.enable = true;
      };
      services = {
        gammastep.enable = true;
        gnome-keyring.enable = true;
        hypridle.enable = true;
        mako.enable = true;
      };
    };

    hyprland = {
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
                sleep 0.1

                swww restore
              else
                notify-send "Failed to find wallpapers directory"
              fi
            '';
        };
      in [
        "${reload}/bin/reload.sh &"
      ];

      extraSettings = {
        general = {
          border_size = 3;

          snap = {
            enabled = true;
            border_overlap = true;
          };
        };

        decoration.rounding = 5;

        input = {
          repeat_rate = 20;
          repeat_delay = 300;

          accel_profile = "flat";
        };

        gestures = {
          workspace_swipe = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        xwayland.force_zero_scaling = true;

        cursor.no_hardware_cursors = true;
      };

      extraBinds = [
        "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod, A, exec, ${pkgs.fuzzel}/bin/fuzzel"
        "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"

        "$mod, Return, exec, ${pkgs.ghostty}/bin/ghostty"
      ];
    };

    home.file = {
      "Pictures/Wallpapers".source = ../../../../assets/wallpapers;
    };

    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };

    gtk.iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };
  };
}
