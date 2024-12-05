{ pkgs, ... }: {
  imports = [
    ./shells/bash.nix
    ./shells/fish.nix

    ./programs/direnv.nix
    ./programs/starship.nix
    ./programs/fastfetch.nix
    ./programs/search.nix
    ./programs/eza.nix
    ./programs/git.nix
    ./programs/ripgrep.nix
    ./programs/nix-index.nix
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

  home.stateVersion = "24.11";
}
