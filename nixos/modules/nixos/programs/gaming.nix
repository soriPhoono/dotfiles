{ pkgs, ... }: {
  hardware.steam-hardware.enable = true;

  programs = {
    steam = {
      enable = true;

      extest.enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      remotePlay.openFirewall = true;
    };

    gamemode = {
      enable = true;

      enableRenice = true;
    };
  };
}
