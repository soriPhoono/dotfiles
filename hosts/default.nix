{ lib, inputs, nixpkgs, username, ... }:
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
      inherit inputs pkgs username;
    };

    modules = [
      ./configuration.nix

      ./vm

      inputs.home-manager.nixosModules.home-manager {
        inputs.home-manager.useGlobalPkgs = true;
        inputs.home-manager.useUserPackages = true;

        inputs.home-manager.extraSpecialArgs = {
          inherit inputs pkgs username;
        };

        inputs.home-manager.users."${username}" = {
          imports = [
            (import ../modules/home.nix)
            (import ./vm/home.nix)
          ];
        };
      }
    ];
  };
}
