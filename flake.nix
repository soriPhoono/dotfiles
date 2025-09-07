{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = inputs @ {snowfall, ...}: let
    lib = snowfall.mkLib {
      inherit inputs;
      src = ./.;
      snowfall = {
        meta = {
          name = "dotfiles";
          title = "Dotfiles";
        };
        namespace = "soriphoono";
      };
    };
  in
    lib.mkFlake {
      inherit inputs;

      src = ./.;

      systems = {
        modules.nixos = with inputs; [
          nixos-facter-modules.nixosModules.facter
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          nix-index-database.nixosModules.nix-index
        ];
      };

      homes = {
        modules = with inputs; [
          sops-nix.homeManagerModules.sops
          nvf.homeManagerModules.default
        ];
      };

      channels-config = {
        allowUnfree = true;
      };

      templates = {
        empty.description = "An empty flake with a basic flake.nix to support a devshell environment";
        rust.description = "A template for a minimal rust supported dev environment supported by devshells";
        dotnet.description = "A template for a minimal dotnet application supported by a devshell";
        python.description = "A template for a minimal python application supported by a devshell";
      };
    };
}
