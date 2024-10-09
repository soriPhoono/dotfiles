{ lib, pkgs, config, ... }:
let cfg = config.desktop.dm.regreet;
in {
  options = {
    desktop.dm.regreet.enable =
      lib.mkEnableOption "Enable regreet display manager";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      # settings.default_session = {
      #   command = with pkgs; "${cage}/bin/cage -s -- ${greetd.regreet}/bin/regreet";
      # };
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
