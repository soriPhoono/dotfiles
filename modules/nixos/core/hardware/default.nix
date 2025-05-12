{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware;
in {
  options.${namespace}.core.hardware = {
    enable = lib.mkEnableOption "Enable hardware support on this system";
  };

  config = lib.mkIf cfg.enable {
    hardware.i2c.enable = true;
  };
}
