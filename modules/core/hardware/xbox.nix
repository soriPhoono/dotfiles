{ lib, config, ... }:
let cfg = config.core.hardware.xbox_controller;
in {
  options = {
    core.hardware.xbox_controller.enable =
      lib.mkEnableOption "Enable Xbox controller support";
  };

  config = lib.mkIf cfg.enable { hardware.xone.enable = true; };
}
