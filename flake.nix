{
  description = "Personal system configurations for home computers";

  inputs = {
    # Repo inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Global imports
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-utils,
    snowfall-lib,
    nixvim,
    ...
  }:
    snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;
      snowfall.namespace = "dotfiles";

      systems.modules.nixos = with inputs; [
        sops-nix.nixosModules.sops
        nixvim.nixosModules.nixvim
        stylix.nixosModules.stylix
      ];

      homes = {
        users."soriphoono@DESKTOP-01GCTUV".modules = with inputs; [
          stylix.homeManagerModules.stylix
        ];

        modules = with inputs; [
          sops-nix.homeManagerModules.sops
          nixvim.homeManagerModules.nixvim
        ];
      };

      templates = {
        base_flake.description = "This is a basic template for a flake";
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.alejandra;
    })
    // flake-utils.lib.eachDefaultSystemPassThrough (system: let
      inherit (nixpkgs) lib;
    in {
      nixvimConfigurations =
        lib.mapAttrs
        (name: type: nixvim.legacyPackages.${system}.makeNixvim (import ./modules/nvim/${name}))
        (lib.filterAttrs
          (name: type: type == "directory" && builtins.pathExists ./modules/nvim/${name}/default.nix)
          (builtins.readDir ./modules/nvim));
    });
}
