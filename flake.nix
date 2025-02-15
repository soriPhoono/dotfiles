{
  description = "Personal system configurations for home computers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {snowfall-lib, ...}:
    snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;
      snowfall.namespace = "dotfiles";

      systems.modules.nixos = with inputs; [
        impermanence.nixosModules.impermanence
        nixos-facter-modules.nixosModules.facter
        disko.nixosModules.disko
        lanzaboote.nixosModules.lanzaboote
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        nix-index-database.nixosModules.nix-index
        nur.modules.nixos.default
      ];

      homes = {
        users."soriphoono@wsl".modules = with inputs; [
          stylix.homeManagerModules.stylix
          nix-index-database.hmModules.nix-index
        ];

        modules = with inputs; [
          sops-nix.homeManagerModules.sops
          nvf.homeManagerModules.default
        ];
      };

      channels-config = {
        allowUnfree = true;
      };
    };
}
