{
  description = "Personal computer configurations";

  outputs = inputs: {
    nixosConfigurations = import ./hosts { inherit inputs; };
  };

  inputs = {
    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Package repo
    nixos-hardware.url =
      "github:NixOS/nixos-hardware"; # Hardware configurations

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # Command-not-found functionality

    # User inputs
    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    }; # Home manager

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };
}
