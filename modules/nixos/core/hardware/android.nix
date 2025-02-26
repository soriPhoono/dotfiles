{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.android;
in {
  options.core.hardware.android.enable = lib.mkEnableOption "Enable Android support";

  config = lib.mkIf cfg.enable {
    programs.adb.enable = true;

    users.users = lib.genAttrs config.core.users.users (_: {
      extraGroups = ["adbusers"];
    });
  };
}
