{
  description = "Personal dotfiles for NixOS";

  outputs =
    inputs@{ self
    , nixpkgs
    , flake-parts
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./hosts
      ];

      perSystem =
        { inputs'
        , pkgs
        , system
        , ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
            };
          };

          treefmt = {
            enableDefaultExcludes = true;

            alejandra.enable = true;
          };
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

    # User environment imports

    home-manager = {
      url = "github:nix-community/home-manager";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Development environment imports

    treefmt-nix.url = "github:numtide/treefmt-nix";

    devshell.url = "github:numtide/devshell";
  };
}
