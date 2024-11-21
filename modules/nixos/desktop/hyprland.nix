{ lib, pkgs, config, ... }:
let
  cfg = config.desktop.hyprland;
in
{
  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Enable hyprland window manager";

      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [

        ];
        description = ''
          List of monitors and their configuration lines.
          Used by hyprland in greetd and nowhere else, 
          but required for system level config of login system.
        '';
        example = [
          "eDP-1, 1920x1080@144, 0x0, 1"
        ];
      };
    };
  };

  config = lib.mkIf cfg.enable {
    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    xdg = {
      portal.extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    environment = {
      systemPackages = with pkgs; [
        playerctl
        brightnessctl

        grim
        slurp

        wl-clipboard-rs

        alacritty
        nautilus
      ];

      variables = {
        NIXOS_OZONE_WL = "1";

        # GDK_BACKEND = "wayland,x11";
        # QT_QPA_PLATFORM = "wayland;xcb";
        # CLUTTER_BACKEND = "wayland";

        QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
        QT_AUTO_SCREEN_SCALE_FACTOR = 1;

        XDG_SESSION_DESKTOP = "Hyprland";

        HYPRCURSOR_SIZE = 24;
      };
    };

    programs = {
      hyprland.enable = true;

      droidcam.enable = true;
      partition-manager.enable = true;
      seahorse.enable = true;
      file-roller.enable = true;

      regreet = {
        enable = true;

        font = {
          name = "AurulentSansM Nerd Font Propo";
          size = 14;
        };

        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };

        settings.background.path = ../../../assets/wallpapers/catppuccin-mountain.jpg;
      };
    };

    services = {
      gnome.gnome-keyring.enable = true;

      gvfs.enable = true;

      upower.enable = true;
      power-profiles-daemon.enable = true;

      pipewire = {
        enable = true;

        jack.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      greetd = {
        enable = true;

        vt = 1;

        settings = {
          default_session = {
            command =
              let
                hypr_config = pkgs.writeText "greetd.conf" ''
                  ${lib.strings.concatMapStringsSep "\n" (monitor: "monitor = ${monitor}") cfg.monitors}

                  input = {
                    repeat_rate = 30;
                    repeat_delay = 200;
                    accel_profile = "flat";
                  }

                  misc = {
                    disable_hyprland_logo = true;
                    disable_splash_rendering = true;

                    mouse_move_enables_dpms = true;
                    key_press_enables_dpms = true;
                  }

                  exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
                '';
              in
              "${pkgs.hyprland}/bin/Hyprland --config ${hypr_config}";
            user = "greeter";
          };

          initial_session = {
            command = "Hyprland";
            user = "soriphoono";
          };
        };
      };
    };

    networking.networkmanager.enable = true;

    users.users.soriphoono.extraGroups = [ "networkmanager" ];
  };
}
