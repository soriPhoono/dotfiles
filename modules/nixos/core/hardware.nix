{ lib, config, ... }: 
let cfg = config.core.hardware;
in {
  options = {
    core.hardware = {
      enable = lib.mkEnableOption "Enable hardware support";

      bluetooth.enable = lib.mkEnableOption "Enable Bluetooth support";

      graphics = {
        enable = lib.mkEnableOption "Enable graphical support";

        extraPackages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [ ];
        };
      };

      inputs = {
        qmk.enable = lib.mkEnableOption "Enable qmk udev rules";
        logitech.mice.enable = lib.mkEnableOption "Enable Logitech mice support";
        controllers.enable = lib.mkEnableOption "Enable game controllers support";
      };
    };
  };

  config = {
    hardware = {
      bluetooth = lib.mkIf (cfg.enable || cfg.bluetooth.enable) {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;

            Enable = "Source,Sink,Media,Socket";
          };
        };
      };

      graphics = lib.mkIf (cfg.enable || cfg.graphics.enable) {
        enable = true;

        extraPackages = cfg.graphics.extraPackages;
        extraPackages32 = cfg.graphics.extraPackages;
      };

      logitech.wireless = lib.mkIf (cfg.enable || cfg.inputs.logitech.mice.enable) {
        enable = true;
        enableGraphical = true;
      };

      keyboard.qmk.enable = lib.mkIf (cfg.enable || cfg.inputs.qmk.enable) true;

      xone.enable = lib.mkIf (cfg.enable || cfg.inputs.controllers.enable) true;
    };
  };
}