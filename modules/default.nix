{
  flake.nixosModules = {
    default = {
      imports = [
        ./core.nix
        ./hardware
      ];
    };
  };
}
