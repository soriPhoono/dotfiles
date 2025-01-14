{ ... }: {
  imports = [
    ./bash.nix
    ./fish.nix

    ./nix-index.nix
    ./eza.nix
    ./fastfetch.nix
    ./bat.nix
    ./fd.nix
    ./fzf.nix
    ./direnv.nix

    ./git.nix
  ];

  options.core = { };

  config = {
    xdg = {
      enable = true;

      userDirs = {
        enable = true;

        createDirectories = true;
      };
    };

    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
