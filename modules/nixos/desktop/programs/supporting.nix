{ lib, config, ... }: let
  cfg = config.desktop.programs.supporting;
in {
  options = {
    desktop.programs.supporting = {
      disks = lib.mkEnableOption "Enable gnome disks";
      droidcam = lib.mkEnableOption "Enable droidcam";
    };
  };

  config = {
    programs.gnome-disks.enable = lib.mkIf cfg.disks true;
    programs.droidcam.enable = lib.mkIf cfg.droidcam true;
  };
}
