{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;

      extest.enable = true;
      remotePlay.openFirewall = true;

      protontricks.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}