{
  pkgs,
  nixosConfig,
  ...
}: {
  imports = [
    ./secrets.nix
    ./ssh.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    p7zip
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

  programs = {
    home-manager.enable = true;

    nh = {
      enable = true;

      clean = {
        enable = true;
        extraArgs = "--keep-since 5d";
      };
    };
  };

  home.stateVersion = nixosConfig.system.stateVersion;
}
