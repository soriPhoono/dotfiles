{
  lib,
  config,
  virtual,
  ...
}: let
  cfg = config.core.hardware.bluetooth;
in {
  options.core.hardware.bluetooth = {
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

    core.boot.impermanence.directories = [
      "/var/lib/bluetooth"
    ];
  };
}
