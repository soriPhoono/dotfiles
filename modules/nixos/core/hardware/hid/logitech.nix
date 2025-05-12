{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.hid.logitech;
in {
  options.${namespace}.core.hardware.hid.logitech.enable = lib.mkEnableOption "Enable logitech drivers";

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
