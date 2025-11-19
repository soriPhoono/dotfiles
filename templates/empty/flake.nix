{
  description = "Empty flake with basic devshell";

  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    actions-nix.url = "github:nialov/actions.nix";
    devenv.url = "github:cachix/devenv";
    agenix-shell.url = "github:aciceri/agenix-shell";
  };

  outputs = inputs @ {
    systems,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      config,
      withSystem,
      moduleWithSystem,
      ...
    }: {
      inherit systems;

      imports = with inputs; [
        actions-nix.flakeModules.default
        devenv.flakeModule
        agenix-shell.flakeModules.default
      ];
      flake = {
      };
      perSystem = {
        config,
        pkgs,
        ...
      }: {
      };
    });
}
