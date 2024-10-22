{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.steam;
in {
  options = {
    desktop.programs.steam.enable = lib.mkEnableOption "Enable steam gaming support";
  };

  config = lib.mkIf cfg.enable {
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

        protontricks.enable = true;

        extraPackages = with pkgs; [ gamescope ];
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
    };
  };
}
