{ inputs
, ...
}: {
  flake.nixosModules = {
    default = {
      imports = with inputs; [
        ./core
      ];
    };
  };
}
