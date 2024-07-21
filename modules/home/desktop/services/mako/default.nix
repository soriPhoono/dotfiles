{ lib, config, ... }:
let cfg = config.desktop.services.mako;
in {
  options = {
    desktop.services.mako.enable = lib.mkEnableOption "Enable mako";
  };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      anchor = "top-right";
      borderRadius = 10;
      borderSize = 3;
      margin = "20,20,20,20";
    };
  };
}
