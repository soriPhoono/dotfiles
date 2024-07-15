{
  description = "SoriPhoono's personal dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # Command-not-found functionality
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = import ./hosts { inherit inputs; };
  };
}
