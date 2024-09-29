{ lib, pkgs, config, ... }:
let cfg = config.desktop;
in {
  imports = [ ./hyprland ./programs ./services ];

  options = {
    desktop.enable =
      lib.mkEnableOption "Enable desktop tooling and required configuration";

    desktop.extraHyprSettings = lib.mkOption {
      type = with lib.types; attrs;
      description = "Extra hyprland settings";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];
      };
    };

    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };

    qt = {
      enable = true;

      platformTheme.name = "gtk";
    };
  };
}
