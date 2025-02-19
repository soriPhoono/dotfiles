{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.gaming;
in {
  options.desktop.gaming.enable = lib.mkEnableOption "Enable gaming software suite";

  config = lib.mkIf cfg.enable {
    hardware.steam-hardware.enable = true;

    programs = {
      steam = {
        enable = true;

        extest.enable = true;
        protontricks.enable = true;
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      gamemode = {
        enable = true;
        enableRenice = true;
      };
    };
  };
}
