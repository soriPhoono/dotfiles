{ lib, pkgs, config, ... }:
let cfg = config.programs.steam;
in {
  options = {
    programs.steam.enable = lib.mkEnableOption "Enable steam programs";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extest.enable = true;

      protontricks.enable = true;

      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
