{ lib, pkgs, config, username, ... }:
let
  cfg = config.desktop.hyprland;

  regreet_config = pkgs.writeTextFile
    {
      name = "regreet.conf";

      text = ''
        exec-once = ${pkgs.greetd.regreet}/bin/regreet
      '';
    };
in
{
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    security = {
      rtkit.enable = true;
      polkit.polkit.enable = true;
    };

    xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    programs = {
      regreet = {
        enable = true;

        cursorTheme = {
          package = pkgs.catppuccin-cursors.mochaTeal;
          name = "catppuccin-mocha-teal-cursors";
        };

        font = {
          package = pkgs.nerdfonts;
          name = "AurulentSansM Nerd Font Propo";
        };

        iconTheme = {
          package = pkgs.papirus-icon-theme;
          name = "Papirus-Dark";
        };

        settings = {
          background = {
            path = ../../../assets/catppuccin-mountain.jpg;
            fit = "Contain";
          };

          GTK = {
            application_prefer_dark_theme = true;
          };
        };
      };

      hyprland.enable = true;

      gnome-disks.enable = true;
      file-roller.enable = true;
    };

    services = {
      greetd = {
        enable = true;

        settings = {
          default_session = {
            command = "${pkgs.hyprland}/bin/Hyprland --config ${regreet_config}";
          };
        };
      };

      upower.enable = true;

      gvfs.enable = true;
      udisks2.enable = true;

      pipewire = {
        enable = true;

        jack.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    networking.networkmanager.enable = true;

    users.users.${username}.extraGroups = [ "networkmanager" ];
  };
}
