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
      ./configuration.nix

      ./vm

      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.extraSpecialArgs = {
          inherit inputs pkgs;
        };

        home-manager.users."${username}" = {
          imports = [
            (import ../modules/home.nix)
            (import ./vm/home.nix)
          ];
        };
      }
    ];
  };
}
