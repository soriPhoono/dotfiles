{
  description = "Personal dotfiles for NixOS";

  outputs =
    inputs @ { nixpkgs
    , flake-parts
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = with inputs; [
        ./hosts

        treefmt-nix.flakeModule
        devshell.flakeModule
      ];

      perSystem =
        { pkgs
        , system
        , ...
        }: {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            enableDefaultExcludes = true;

            programs = {
              # Workflow formatters
              actionlint.enable = true;

              mdformat.enable = true;

              # System script formatters
              nixpkgs-fmt.enable = true;
              deadnix.enable = true;
              statix.enable = true;

              shfmt.enable = true;
              shellcheck.enable = true;

              # Desktop formatters
              clang-format.enable = true;

              zig.enable = true;

              rustfmt.enable = true;

              google-java-format.enable = true;

              black.enable = true;
              isort.enable = true;
              mypy.enable = true;

              stylua.enable = true;

              yamlfmt.enable = true;

              # Web development formatters
              deno.enable = true;
            };
          };

          devShells = import ./devshells { inherit pkgs; };
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

    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # Development environment imports

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell.url = "github:numtide/devshell";
  };
}
