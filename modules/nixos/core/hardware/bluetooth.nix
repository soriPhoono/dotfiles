{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.hardware.bluetooth;
in {
  options.${namespace}.core.hardware.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth hardware support";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;

          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
