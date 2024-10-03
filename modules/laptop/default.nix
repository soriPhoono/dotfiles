{ lib, config, ... }:
let cfg = config.laptop;
in {
  imports = [ ./droidcam.nix ];

  options = {
    laptop.enable = lib.mkEnableOption "Enable laptop support";
  };

  config = lib.mkIf cfg.enable {
    laptop.droidcam.enable = true;
  };
}
