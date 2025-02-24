{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.gaming;
in {
  options.desktop.gaming.enable = lib.mkEnableOption "Enable gaming desktop setup";

  config = lib.mkIf cfg.enable {
    hardware.steam-hardware.enable = true;

    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

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

        extraPackages = with pkgs; [
          gamescope
        ];
      };
    };
  };
}
