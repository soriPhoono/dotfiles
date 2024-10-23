{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.regreet;
in
{
  options = {
    desktop.programs.regreet = {
      enable = lib.mkEnableOption "Enable regreet login screen";
    };
  };

  config = lib.mkIf cfg.enable {
    desktop.services.greetd.enable = true;

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

      settings = {
        background = {
          path = ../../../../assets/catppuccin-mountain.jpg;
          fit = "Contain";
        };

        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };
  };
}
