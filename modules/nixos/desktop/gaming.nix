{
  lib,
  pkgs,
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
        package = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
            ];
        };

        extest.enable = true;

        protontricks.enable = true;

        gamescopeSession.enable = true;
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
