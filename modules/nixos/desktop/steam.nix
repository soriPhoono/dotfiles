{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.steam;
in
{
  options = {
    desktop.programs.steam = {
      enable = lib.mkEnableOption "Enable steam gaming support";

      session = {
        enable = lib.mkEnableOption "Enable gamescope session";

        output = lib.mkOption {
          type = lib.types.str;
          description = "Output to use for gamescope";
        };

        resolution = {
          width = lib.mkOption {
            type = lib.types.int;
            default = 1920;
            description = "Width of the gamescope window";
          };

          height = lib.mkOption {
            type = lib.types.int;
            default = 1080;
            description = "Height of the gamescope window";
          };

          refreshRate = lib.mkOption {
            type = lib.types.int;
            default = 144;
            description = "Refresh rate of the gamescope window";
          };
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
          extraPkgs = with pkgs; [
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
          "-w ${cfg.session.resolution.width}"
          "-h ${cfg.session.resolution.height}"
          "-r ${cfg.session.resolution.refreshRate}"
          "--force-grab-cursor"
          "-fb"
        ];
      };
    };
  };
}
