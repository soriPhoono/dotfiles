{
  description = "Empty flake with basic devshell";

  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    actions-nix = {
      url = "github:nialov/actions.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    agenix-shell = {
      url = "github:aciceri/agenix-shell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs = inputs @ {
    systems,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      inherit systems;

      imports = with inputs; [
        actions-nix.flakeModules.default
        devenv.flakeModule
        agenix-shell.flakeModules.default
      ];
      flake = {
      };
      perSystem = _: {
      };
    });
}
