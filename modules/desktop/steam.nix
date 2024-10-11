{ lib, pkgs, config, ... }:
let cfg = config.desktop.steam;
in {
  options = {
    desktop.steam.enable = lib.mkEnableOption "Enable steam gaming support";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extest.enable = true;
        package = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
            libkrb5
            keyutils
          ];
        };

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
