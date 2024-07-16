{ lib, config, ... }:
let cfg = config.xbox;
in {
  options = {
    xbox.enable = lib.mkEnableOption "Enable Xbox controller services";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      xone.enable = true;
      steam-hardware.enable = true;
      uinput.enable = true;
    };
  };
}
