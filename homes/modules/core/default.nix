{ nixosConfig, ... }: {
  imports = [ ./shell.nix ./utils.nix ./git.nix ./neovim ];

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
