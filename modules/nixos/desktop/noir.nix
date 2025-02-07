{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    security = {
      polkit.enable = true;

      # allow wayland lockers to unlock the screen
      pam.services.hyprlock.text = "auth include login";
    };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    xdg.portal = {
      enable = true;

      xdgOpenUsePortal = true;

      config = {
        common.default = ["gtk"];
        hyprland.default = ["gtk" "hyprland"];
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    programs = {
      hyprland.enable = true;

      hyprlock.enable = true;

      nautilus-open-any-terminal = {
        enable = true;

        terminal = "kitty";
      };

      kdeconnect.enable = true;

      seahorse.enable = true;
    };

    services = {
      hypridle.enable = true;

      gnome.sushi.enable = true;
    };
  };
}
