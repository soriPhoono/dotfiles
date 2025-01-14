{ ... }: {
  imports = [
    ./fish.nix

    ./eza.nix

    ./git.nix
  ];

  options.core = { };

  config = {
    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
