{
  description = "Personal system configurations for home computers";

  inputs = {
    # Repo inputs
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # System inputs
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Global imports
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, systems, nixpkgs, ... }:    {
    templates = import ./templates;

    nixosModules = import ./modules/nixos;

    homeModules = import ./modules/home;

    nixosConfigurations = import ./systems { inherit self inputs;
    inherit (nixpkgs) lib; };
  };
}
