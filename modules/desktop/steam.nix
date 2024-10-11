{ lib, pkgs, config, ... }:
let cfg = config.desktop.steam;
in {
  options = {
    desktop.steam.enable = true;
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extest.enable = true;

        protontricks.enable = true;

        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };

      gamemode = {
        enable = true;
        enableRenice = true;
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
  };
}
