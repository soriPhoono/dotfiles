{
  description = "Basic flake for a nix project";

  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

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

      flake = {
      };

      perSystem = {
        system,
        pkgs,
        ...
      }: rec {
        checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            gptcommit.enable = true;

            alejandra.enable = true;
            flake-checker.enable = true;
            statix.enable = true;
          };
        };

        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          inherit (checks.pre-commit-check) shellHook;

          buildInputs = checks.pre-commit-check.enabledPackages;
        };
      };
    };
}
