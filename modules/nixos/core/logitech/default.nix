{ lib, config, ... }:
let cfg = config.core.logitech;
in {
  options = {
    core.logitech.enable = lib.mkEnableOption "Enable Logitech services";
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
