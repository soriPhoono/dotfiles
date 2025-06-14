{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.adb;
in {
  options.core.hardware.adb = {
    enable = lib.mkEnableOption "Enable adb support";
  };

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;
  };
}
