{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.gpu;
in {
  options.${namespace}.core.hardware.gpu = {
    enable = lib.mkEnableOption "Enable graphics driver features";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
