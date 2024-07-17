{ lib, pkgs, config, ... }:
let cfg = config.openrgb;
in {
  options = {
    openrgb.enable = lib.mkEnableOption "Enable OpenRGB service";
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
