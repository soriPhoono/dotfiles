{
  description = "Personal computer configurations";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./hosts ];

      systems = [ "x86_64-linux" ];
    };

  inputs = {
    # Schema
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Package repo
    nixos-hardware.url =
      "github:NixOS/nixos-hardware"; # Hardware configurations

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # Command-not-found functionality

    # User inputs
    hm = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    }; # Home manager

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "hm";
      };
    };
  };
}
