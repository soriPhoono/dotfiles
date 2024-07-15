{ lib, inputs, vars, ... }:
let
  system = "x86_64-linux";

  pkgs = import inputs.nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  inherit (import ../../users/common) cli;
in lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit lib inputs pkgs vars;
  };

  modules = with inputs; [
    nixos-wsl.nixosModules.default

    ../../modules

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = { inherit inputs pkgs vars; };

        users.${vars.defaultUser} = {
          imports = cli ++ [
            ../../users/soriphoono.nix
          ];
        };
      };
    }
  ];
}
