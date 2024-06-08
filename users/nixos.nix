{ vars, ... }: {
  imports = [
    ./modules/cli.nix
    ./modules/development
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}