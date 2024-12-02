{
  description = "Description for the project";

  inputs = {
    # Repo dependencies
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Framework dependencies
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System dependencies
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # System dependencies

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall = {
        root = ./nix;

        namespace = "soriphoono";

        meta = {
          name = "dotfiles";

          title = "Personal dotfiles";
        };
      };

      alias.shells.default = "main-shell";

      channels-config = {
        allowUnfree = true;
      };

      systems = with inputs; {
        modules.nixos = [
          stylix.nixosModules.stylix
          nixvim.nixosModules.nixvim
        ];

        hosts = {
          wsl.modules = [
            nixos-wsl.nixosModules.default
            {
              wsl = {
                enable = true;

                defaultUser = "soriphoono";
              };
            }
          ];
        };
      };
    };
}
