{ lib, pkgs, config, ... }:
let
  cfg = config.desktop.gtk;
in
{
  options = {
    desktop.gtk.enable = lib.mkEnableOption "Enable gtk settings";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;

      cursorTheme = {
        package = pkgs.catppuccin-cursors.mochaTeal;
        name = "catppuccin-mocha-teal-cursors";
      };

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "ePapirus-Dark";
      };

      font = {
        name = "AurulentSansM Nerd Font Propo";
      };
    };
  };
}
