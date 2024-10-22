{ lib, config, ... }:
let cfg = config.desktop.programs.droidcam;
in {
  options = {
    desktop.programs.droidcam = { enable = lib.mkEnableOption "Enable droidcam"; };
  };

  config = lib.mkIf cfg.enable { programs.droidcam.enable = true; };
}
