{ lib, nixpkgs, home-manager, vars, ... }:
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
      inherit pkgs vars;
    };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users."${user}" = [
          (import ../user/home.nix { inherit pkgs vars; }) # Import the home.nix file
        ];
      }
    ];
  };
}
