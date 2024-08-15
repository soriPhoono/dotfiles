{
  description = "SoriPhoono's personal dotfiles";

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./nixos;

      snowfall = {
        namespace = "soriphoono";

        meta = {
          name = "dotfiles";
          title = "dotfiles";
        };
      };

      channels-config.allowUnfree = true;

      systems = {
        hosts = {
          wsl.modules = with inputs; [
            nixos-wsl.nixosModules.wsl
            {
              wsl = {
                enable = true;
                defaultUser = "soriphoono";
              };
            }
          ];
        };
      };

      homes = {
        modules = with inputs; [
          stylix.homeManagerModules.stylix
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

    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";

      flake = false;
    };

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

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "";
      };
    };
  };
}
