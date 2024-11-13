{ lib, config, ... }: let
  cfg = config.desktop.programs.supporting;
in {
  options = {
    desktop.programs.supporting = {
      droidcam = lib.mkEnableOption "Enable droidcam";
    };
  };

  config = {
    programs = {
      partition-manager.enable = true;
      droidcam.enable = lib.mkIf cfg.droidcam true;
    };
  };
}
