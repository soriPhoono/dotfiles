{ lib, nixpkgs, home-manager, username, ... }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  test_vm = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit pkgs username;
    };
    modules = [
      ./configuration.nix

      ./vm

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users."${username}" =
          (import ../modules/home.nix { inherit pkgs username; }); # Import the home.nix file
      }
    ];
  };
}
