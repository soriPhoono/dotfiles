{
  description = "Basic flake for a nix project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
  };
}
