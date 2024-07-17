{ lib, pkgs, config, ... }:
let cfg = config.programs.gaming;
in {
  options = {
    programs.gaming.enable = lib.mkEnableOption "Enable gaming programs";
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
