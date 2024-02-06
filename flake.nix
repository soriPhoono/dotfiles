{
  description = "Set of personal NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: add home manager for personal rice
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    user = "soriphoono";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit nixpkgs home-manager user;
      }
    );
  };
}
