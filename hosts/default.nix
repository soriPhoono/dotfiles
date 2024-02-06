{ lib, nixpkgs, home-manager, user, ... }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  test_vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit system pkgs user;
    };
    modules = [
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users."${user}" = import ./home.nix; # Import the default home.nix file
      }
    ];
  };
}
