{ lib, config, ... }:
let
  cfg = config.desktop.programs.openrgb;
in
{
  options = {
    desktop.programs.openrgb = {
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
