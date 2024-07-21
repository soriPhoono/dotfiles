{ lib, config, ... }:
let cfg = config.core.qmk;
in {
  options = {
    core.qmk.enable = lib.mkEnableOption "Enable userspace qmk driver support";
  };

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;
  };
}
