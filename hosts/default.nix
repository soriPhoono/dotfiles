#
#   Author: Soriphoono
#   Date: 2024-02-04
#   Description: NixOS configuration flake for my personal computers/home-server
#
#   flake.nix
#    └─ ./hosts
#        ├─ default.nix *
#        ├─ configuration.nix
#        └─ ./<host>.nix
#            └─ default.nix
#

{ lib, inputs, nixpkgs, nixos-hardware, home-manager, vars, ... }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  # Define hardware configurations here.
  home_desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system vars;
      host = {
        hostName = "home_desktop";
      };
    };
    modules = [
      ./configuration.nix
      # ./home_desktop

      home-manager.nixosModules.home-manager {
        inherit vars;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${vars.user} = {
          imports = [
            ./home.nix # Include the core user's home.nix
          ];
        };
      }
    ];
  };
}
