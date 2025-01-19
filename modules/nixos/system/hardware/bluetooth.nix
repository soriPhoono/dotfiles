{
  lib,
  config,
  virtual,
  ...
}: let
  cfg = config.system.hardware.bluetooth;
in {
  options.system.hardware.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth support";
  };

  config = lib.mkIf (!virtual && cfg.enable) {
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
