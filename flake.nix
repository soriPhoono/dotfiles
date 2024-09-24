{
  description = "Personal dotfiles for NixOS";

  outputs =
    { nixpkgs
    , flake-parts
    , ...
    } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = with inputs; [
        ./hosts
        ./modules
      ];

      perSystem =
        { pkgs
        , system
        , ...
        }: {
          # TODO: Restore this if unfree packages break
          /* _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
            };
          }; */

          formatter = pkgs.nixpkgs-fmt;

          devShells.default = (import ./shell.nix { inherit pkgs; });
        };
    };

  inputs = {
    # Core imports

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # System-specific imports

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # User environment imports

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

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Development environment imports

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-darwin.follows = "";
      };
    };
  };
}
