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
      polkit = {
        enable = true;

        extraConfig = ''
          polkit.addRule(function(action, subject) {
            if (
              subject.isInGroup("users")
                && (
                  action.id == "org.freedesktop.login1.reboot" ||
                  action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                  action.id == "org.freedesktop.login1.power-off" ||
                  action.id == "org.freedesktop.login1.power-off-multiple-sessions"
                )
              )
            {
              return polkit.Result.YES;
            }
          });
        '';
      };

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
        xdg-desktop-portal-gtk
      ];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
    };

    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
            user = "greeter";
          };
        };
      };

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;

      hypridle.enable = true;

      psd = {
        enable = true;
        resyncTimer = "10m";
      };
    };
  };
}
