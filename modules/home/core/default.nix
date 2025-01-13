{ nixosConfig, ... }: {
  imports = [
    ./fish.nix

    ./git.nix
  ];

  options.core = {};

  config = {
    home.stateVersion = nixosConfig.system.stateVersion;

    programs.home-manager.enable = true;
  };
}
