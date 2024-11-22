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
    desktop.enable = true;

    security.polkit.enable = true;

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
      ];
    };

    programs = {
      hyprland.enable = true;

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
      greetd = {
        enable = true;

        vt = 1;
      };
    };
  };
}
