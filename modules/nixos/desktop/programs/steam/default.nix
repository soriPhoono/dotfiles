{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.steam;
in {
  options = {
    desktop.programs.steam.enable = lib.mkEnableOption "Enable steam programs";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        extest.enable = true;

        protontricks.enable = true;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      gamemode = {
        enable = true;
        enableRenice = true;
      };
    };
  };
}
