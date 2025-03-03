{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.hardware.android;
in {
  options.core.hardware.android.enable = lib.mkEnableOption "Enable Android support";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      android-tools
    ];

    programs.adb.enable = true;

    users.extraUsers = lib.listToAttrs (
      map (user: {
        inherit (user) name;

        value = {
          extraGroups = [
            "adbusers"
          ];
        };
      })
      config.core.suites.users.users
    );
  };
}
