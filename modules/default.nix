{
  flake.nixosModules = {
    default = {
      imports = [
        ./core
      ];
    };
  };
}
