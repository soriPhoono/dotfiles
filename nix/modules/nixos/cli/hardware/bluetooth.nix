{ lib, config, ... }:
let cfg = config.cli.hardware.bluetooth;
in {
  options.cli.hardware.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";

  config.hardware.bluetooth = lib.mkIf cfg.enable {
    enable = true;
    powerOnBoot = true;

    settings.General = {
      Experimental = true;

      Enable = "Source,Sink,Media,Socket";
    };
  };
}
