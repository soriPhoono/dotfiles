{
  description = "Personal system configurations for home computers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "";
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
        nixos-facter-modules.nixosModules.facter
        disko.nixosModules.disko
        lanzaboote.nixosModules.lanzaboote
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        nix-index-database.nixosModules.nix-index
        nixvim.nixosModules.nixvim
        nur.modules.nixos.default
      ];

      homes = {
        users."soriphoono@wsl".modules = with inputs; [
          stylix.homeManagerModules.stylix
          nix-index-database.hmModules.nix-index
        ];

        modules = with inputs; [
          sops-nix.homeManagerModules.sops
          nixvim.homeManagerModules.nixvim
        ];
      };

      templates = {
        base_flake.description = "This is a basic template for a flake";
      };

      channels-config = {
        allowUnfree = true;
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
        (name: _: nixvim.legacyPackages.${system}.makeNixvim (import ./modules/nvim/${name}))
        (lib.filterAttrs
          (name: type: type == "directory" && builtins.pathExists ./modules/nvim/${name}/default.nix)
          (builtins.readDir ./modules/nvim));
    });
}
