{ lib, config, ... }:
let cfg = config.core.hardware.xbox;
in
{
  options = {
    core.hardware.xbox = {
      enable = lib.mkEnableOption "Enable Xbox support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      xone.enable = true;
      steam-hardware.enable = true;
      uinput.enable = true;
    };
  };
}
