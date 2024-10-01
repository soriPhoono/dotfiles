{ lib, config, ... }:
let cfg = config.hardware.xbox_controller;
in {
  options = {
    hardware.xbox_controller.enable =
      lib.mkEnableOption "Enable Xbox controller support";
  };

  config = lib.mkIf cfg.enable { hardware = { xone.enable = true; }; };
}
