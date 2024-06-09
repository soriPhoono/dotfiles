{ inputs, pkgs, vars, ... }: let
  inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit (vars) system;

  specialArgs = {
    inherit inputs pkgs vars;
  };

  modules = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          inherit inputs pkgs vars;
        };

        users.${vars.defaultUser} = import ../../users/${vars.defaultUser}.nix;
      };
    }
  ];
}