{ ... }: {
  imports = [
    ./fish.nix

    ./git.nix
  ];

  options.core = { };

  config = {
    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
