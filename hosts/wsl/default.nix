{ system, inputs, pkgs, vars, stateVersion }: let
  inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs pkgs vars;
  };

  modules = [
    inputs.nixos-wsl.nixosModules.default {
      system.stateVersion = "${stateVersion}";

      wsl = {
        enable = true;

        defaultUser = "${vars.defaultUser}";
      };
    }

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          inherit inputs pkgs vars stateVersion;
        };

        users.${vars.defaultUser} = import ../../users/${vars.defaultUser}.nix;
      };
    }
  ];
}
