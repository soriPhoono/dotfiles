{
  description = "SoriPhoono's personal dotfiles";

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        namespace = "soriphoono";

        meta = {
          name = "dotfiles";
          title = "dotfiles";
        };
      };

      systems = {
        modules.nixos = with inputs; [
          nix-index-db.nixosModules.nix-index
        ];

        hosts.wsl.modules = with inputs; [
          nixos-wsl.nixosModules.default {
            wsl.enable = true;
            wsl.defaultUser = "soriphoono";

            system.stateVersion = "24.11";
          }
        ];
      };

      homes = {
        modules = with inputs; [
          stylix.homeManagerModules.stylix
        ];

        users.soriphoono.modules = with inputs; [

        ];
      };
    };

  inputs = {
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
}
