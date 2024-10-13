{ lib, config, pkgs, ... }:
let cfg = config.desktop.services.mako;
in {
  options = {
    desktop.services.mako = {
      enable = lib.mkEnableOption "Enable mako notification daemon";
      rounding = lib.mkOption {
        type = with lib.types; int;
        description = "Rounding on mako windows";
      };
      border_size = lib.mkOption {
        type = with lib.types; int;
        description = "Border thickness";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      anchor = "top-right";
      margin = "20,20,5";

      borderRadius = cfg.rounding;
      borderSize = cfg.border_size;

      defaultTimeout = 3000;

      maxVisible = 3;

      height = 180;
      width = 320;

      iconPath = "${pkgs.papirus-icon-theme}/usr/share/icons";
    };
  };
}
