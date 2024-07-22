{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.util.gtk;
in {
  options = {
    desktop.programs.util.gtk.enable = lib.mkEnableOption "Enable gtk configuration";
  };

  config = {
    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "ePapirus-Dark";
      };
    };

    qt.enable = true;
  };
}
