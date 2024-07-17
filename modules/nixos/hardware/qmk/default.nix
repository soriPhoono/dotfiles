{ lib, config, ... }:
let cfg = config.qmk;
in {
  options = {
    qmk.enable = lib.mkEnableOption "Enable userspace qmk driver support";
  };

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;
  };
}
