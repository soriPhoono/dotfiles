{ lib, config, ... }: let
  cfg = config.desktop.programs.supporting;
in {
  options = {
    desktop.programs.supporting = {
      disks = lib.mkEnableOption "Enable gnome disks";

    };
  };

  config = {
    programs.gnome-disks.enable = lib.mkIf cfg.desktop.programs.supporting.disks true;
  };
}
