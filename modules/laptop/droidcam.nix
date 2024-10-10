{ lib, config, ... }:
let cfg = config.laptop.droidcam;
in {
  options = {
    laptop.droidcam = { enable = lib.mkEnableOption "Enable droidcam"; };
  };

  config = lib.mkIf cfg.enable { programs.droidcam.enable = true; };
}
