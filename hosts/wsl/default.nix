{ inputs, pkgs, vars, ... }: let
  inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit (vars) system;

  specialArgs = {
    inherit inputs pkgs vars;
  };

  modules = [
    inputs.nixos-wsl.nixosModules.default {
      system.stateVersion = "${vars.stateVersion}";

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
          inherit inputs pkgs vars;
        };

        users.${vars.defaultUser} = import ../users/${vars.defaultUser}.nix;
      };
    }
  ];
}