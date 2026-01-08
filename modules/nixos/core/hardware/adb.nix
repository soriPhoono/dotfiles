{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.hardware.adb;
in {
  options.core.hardware.adb = {
    enable = lib.mkEnableOption "Enable adb support";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      android-tools
    ];

    users.extraUsers =
      builtins.mapAttrs (name: user: {
        extraGroups = [
          "adbusers"
        ];
      })
      (lib.filterAttrs
        (name: content: content.admin)
        config.core.users);
  };
}
