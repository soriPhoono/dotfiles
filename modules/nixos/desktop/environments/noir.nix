{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.noir;
in {
  options.desktop.environments.noir = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    desktop.programs.regreet.enable = true;

    security = {
      polkit.enable = true;
      # allow wayland lockers to unlock the screen
      pam.services.hyprlock.text = "auth include login";
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

    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    services = {
      greetd = {
        settings = {
          initial_session = {
            command = "Hyprland";
          };
        };
      };
      seatd.enable = true;

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;

      geoclue2.appConfig.gammastep = {
        isAllowed = true;
        isSystem = false;
      };

      hypridle.enable = true;
    };
  };
}
