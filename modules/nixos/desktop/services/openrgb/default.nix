{ lib, pkgs, config, ... }:
let cfg = config.services.openrgb;
in {
  options = {
    services.openrgb.enable = lib.mkEnableOption "Enable OpenRGB service";
  };

  config = lib.mkIf cfg.enable {
    hardware.i2c.enable = true;

    services.hardware.openrgb = {
      enable = true;
    };

    users.users.soriphoono.extraGroups = [
      "video"
    ];
  };
}
