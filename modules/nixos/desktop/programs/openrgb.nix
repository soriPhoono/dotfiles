{ lib, config, ... }:
let
  cfg = config.desktop.openrgb;
in
{
  options = {
    desktop.openrgb = {
      enable = lib.mkEnableOption "Enable openrgb";
    };
  };

  config = lib.mkIf cfg.enable {
    services.hardware.openrgb = {
      enable = true;

      motherboard = "intel";
    };
  };
}
