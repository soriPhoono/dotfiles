{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.suites.gaming;
in {
  options.desktop.suites.gaming = {
    enable = lib.mkEnableOption "Enable gaming desktop setup";

    mode = lib.mkOption {
      type = with lib.types; enum ["desktop" "console" "gameServer" "streamServer"];
      description = "The type of gaming setup to enable";

      default = "desktop";
    };

    gamescopeMode = let
      gamescopeModeType = lib.types.submodule {
        options = {
          args = lib.mkOption {
            type = with lib.types; listOf str;
            description = "Arguments to pass to the gamescope binary";

            default = [];
          };

          env = lib.mkOption {
            type = with lib.types; attrsOf str;
            description = "Environment variables to set for the gamescope binary";

            default = {};
          };
        };
      };
    in
      lib.mkOption {
        type = gamescopeModeType;
        description = "The options for the gamescope binary (only effects desktop and console mode)";

        default = {};
      };
  };

  config = lib.mkIf cfg.enable {
    hardware.steam-hardware.enable = lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) true;

    environment.systemPackages = with pkgs;
      lib.mkIf (cfg.mode == "desktop") [
        lutris
        bottles

        prismlauncher
        gzdoom
        shattered-pixel-dungeon
        osu-lazer-bin

        winetricks
      ];

    programs = {
      gamemode = lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) {
        enable = true;
        enableRenice = true;
      };

      gamescope.enable = lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) true;

      steam = {
        enable = true;

        extraPackages = with pkgs;
          lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) [
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

        extraCompatPackages = with pkgs;
          lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) [
            proton-ge-bin
          ];

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = lib.mkIf ((cfg.mode == "desktop") || (cfg.mode == "console")) true;

        gamescopeSession =
          lib.mkIf ((cfg.mode == "desktop")
            || (cfg.mode
              == "console"))
          ({
              enable = true;
            }
            // cfg.gamescopeMode);
      };
    };

    services.ananicy = {
      enable = true;
      extraRules = [
        {
          name = "gamescope";

          nice = 20;
        }
      ];
    };
  };
}
