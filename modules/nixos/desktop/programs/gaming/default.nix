{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.gaming;
in {
  options = {
    desktop.programs.gaming.enable = lib.mkEnableOption "Enable steam programs";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extest.enable = true;

        protontricks.enable = true;

        gamescopeSession = {
          enable = true;

          args = [
            "-w 1920"
            "-h 1080"
            "-r 144"
            "-fbe"
          ];
        };
      };

      gamemode = {
        enable = true;
        enableRenice = true;
      };

      gamescope = {
        enable = true;
        capSysNice = true;

        env = {

        };

        args = [
          "-w 1920"
          "-h 1080"
          "-r 144"
          "-fbe"
        ];
      };
    };
  };
}
