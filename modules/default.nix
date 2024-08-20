{
  flake.nixosModules = {
    default = {
      imports = [
        ./core
        ./cli
      ];
    };
  };
}
