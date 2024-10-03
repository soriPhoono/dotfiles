{ lib, pkgs, config, ... }:
let cfg = config.desktop.regreet;
in {
  imports = [ ./greetd.nix ];

  options = {
    desktop.regreet.enable =
      lib.mkEnableOption "Enable regreet display manager";
  };

  config = lib.mkIf cfg.enable {
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
        name = "catppuccin-mocha-teal-standard+default";
      };

      settings = {
        background = {
          path = ../../assets/catppuccin-mountain.jpg;
          fit = "Contain";
        };
      };
    };
  };
}
