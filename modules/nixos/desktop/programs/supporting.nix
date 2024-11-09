{ lib, config, ... }: let
  cfg = config.desktop.programs.supporting;
in {
  options = {
    desktop.programs.supporting = {
      disks = lib.mkEnableOption "Enable gnome disks";
      partition-manager = lib.mkEnableOption "Enable partition manager";
      droidcam = lib.mkEnableOption "Enable droidcam";
    };
  };

  config = {
    programs = {
      gnome-disks.enable = lib.mkIf cfg.disks true;
      partition-manager.enable = lib.mkIf cfg.partition-manager true;
      droidcam.enable = lib.mkIf cfg.droidcam true;
    };
  };
}
