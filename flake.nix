#
#   Author: Soriphoono
#   Date: 2024-02-04
#   Description: NixOS configuration flake for my personal computers/home-server
#
#   flake.nix *
#    └─ ./hosts
#

let
  release = "23.11";
in
{
  # This is the main entry point to your NixOS configuration(s).

  # Description entry for the main flake of the system configuration.
  description = "Personal NixOS configurations for my personal computers/home-server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-${release}";            # main packages repository
    nixos-hardware.url = "github:nixos/nixos-hardware/master";        # hardware specific packages/additions

    home-manager = {
      url = "github:nix-community/home-manager/release-${release}";
      inputs.nixpkgs.follows = "nixpkgs";
    };                                                                # home-manager for user configurations
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, ... }:
    let
      vars = {
        user = "soriphoono";
        terminal = "alacritty";
        editor = "nvim";
      };
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit nixpkgs nixos-hardware home-manager vars;
        }
      );
    };
}
