{ lib, pkgs, config, ... }:
let cfg = config.desktop;
in {
  imports = [
    ./hyprland.nix
  ];

  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop settings";
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;

      cursorTheme = {
        package = pkgs.bibata-cursors-translucent;
        name = "Bibata_Ghost";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };
  };
}
