{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wine-wayland
    winetricks

    prismlauncher
  ];

  programs = {
    gamemode = {
      enable = true;

      enableRenice = true;
    };

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