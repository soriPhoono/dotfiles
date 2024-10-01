{ nixosConfig, ... }: {
  imports = [ ./programs ./shells ./neovim ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = nixosConfig.system.stateVersion;
}
