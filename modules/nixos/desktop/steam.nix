{ lib, pkgs, config, ... }:
let cfg = config.desktop.steam;
in
{
  options = {
    desktop.steam = {
      enable = lib.mkEnableOption "Enable steam gaming support";

      session = {
        enable = lib.mkEnableOption "Enable gamescope session";

        output = lib.mkOption {
          type = lib.types.str;
          description = "Output to use for gamescope";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.steam-hardware.enable = true;

    programs = {
      steam = {
        enable = true;

        package = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
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

        gamescopeSession = lib.mkIf cfg.session.enable {
          enable = true;

          args = [
            "--prefer-output ${cfg.session.output}"
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

        args = [
          "-w 1920"
          "-h 1080"
          "-r 144"
          "--force-grab-cursor"
          "-fb"
        ];
      };
    };
  };
}
