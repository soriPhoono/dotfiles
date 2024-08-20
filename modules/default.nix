{
  flake.nixosModules = {
    default = {
      imports = [
        ./core
        ./hardware
      ];
    };
  };
}
