{ lib, config, ... }:
let cfg = config.logitech;
in {
  options = {
    logitech.enable = lib.mkEnableOption "Enable Logitech services";
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
