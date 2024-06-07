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
  ];
}