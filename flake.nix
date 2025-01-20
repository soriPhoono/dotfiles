{
  description = "Personal system configurations for home computers";

  inputs = {
    # Repo inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    # Assembler inputs
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    snowfall-lib,
    ...
  }:
    snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;
      snowfall.namespace = "dotfiles";

      systems.modules.nixos = with inputs; [
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
      ];

      homes.modules = with inputs; [
        sops-nix.homeManagerModules.sops
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };

      alias = {
        shells.default = "development";
      };

      templates = {
        base_flake.description = "This is a basic template for a flake";
      };

      channels-config.allowUnfree = true;
    };
}
