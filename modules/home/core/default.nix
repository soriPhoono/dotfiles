{
  pkgs,
  nixosConfig,
  ...
}: {
  imports = [
    ./secrets.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    zip
    unzip

    unrar
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  snowfallorg.user.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = nixosConfig.system.stateVersion;
}
