{ nixosConfig, ... }: {
  imports = [
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fastfetch.nix
    ./programs/git.nix
    ./programs/nix-index.nix
    ./programs/ripgrep.nix
    ./programs/search.nix
    ./programs/starship.nix
    ./programs/zellij.nix
  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = nixosConfig.system.stateVersion;
}
