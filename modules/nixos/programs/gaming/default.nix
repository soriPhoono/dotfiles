{ lib, pkgs, config, ... }: {
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
}
