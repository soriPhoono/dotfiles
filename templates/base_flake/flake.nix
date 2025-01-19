{
  description = "Basic flake for a nix project";

  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    self,
    systems,
    nixpkgs,
    flake-parts,
    ...
  }: let
    systems = import systems;
  in
    flake-parts.mkFlake {inherit inputs;} {
      inherit systems;

      imports = with inputs; [
        pre-commit-hooks.flakeModule
        treefmt-nix.flakeModule
      ];

      flake = {
      };

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;

        treefmt = {
          programs.alejandra.enable = true;
        };

        pre-commit.settings.hooks = {
          gptcommit.enable = true;

          alejandra.enable = true;
          flake-checker.enable = true;
          statix.enable = true;
        };

        devShells.default = pkgs.mkShell {
          shellHook = ''
            ${config.pre-commit.installationScript}

            echo 1>&2 "Welcome to the base development shell!"
          '';
        };
      };
    };
}
