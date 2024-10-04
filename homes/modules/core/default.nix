{ nixosConfig, ... }: {
  imports = [ ./programs ./shells ];

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
