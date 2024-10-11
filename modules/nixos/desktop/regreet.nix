{ lib, pkgs, config, ... }:
let cfg = config.desktop.regreet;
in {
  options = {
    desktop.regreet.enable =
      lib.mkEnableOption "Enable regreet display manager";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
    };

    programs.regreet = {
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

      theme = {
        package = pkgs.catppuccin-gtk.overrideAttrs {
          accents = "teal";
          variant = "mocha";
        };
        name = "catppuccin-mocha-teal-standard";
      };

      settings = {
        background = {
          path = ../../../assets/catppuccin-mountain.jpg;
          fit = "Contain";
        };
      };
    };
  };
}
