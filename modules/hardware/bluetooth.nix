{ lib, config, ... }:
let cfg = config.hardware.bluetooth;
in {
  options = {
    hardware.bluetooth.enable = lib.mkEnableOption "Enable bluetooth support";
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
