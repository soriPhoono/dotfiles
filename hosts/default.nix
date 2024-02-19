{ lib, inputs, nixpkgs, ... }:
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
      inherit inputs pkgs;
    };

    modules = [
      ./vm

      ../system

      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit inputs pkgs;
        };

        home-manager.users.soriphoono = {
          imports = [
            (import ../home/home.nix)
            (import ./vm/home.nix)
          ];
        };
      }
    ];
  };
}
