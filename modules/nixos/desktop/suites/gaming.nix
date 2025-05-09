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
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      lib.mkIf (cfg.mode == "desktop") [
        mangohud

        bottles
        prismlauncher
        gzdoom
        shattered-pixel-dungeon
        osu-lazer-bin
      ];

    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      steam = {
        enable = true;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = true;
      };
    };
  };
}
