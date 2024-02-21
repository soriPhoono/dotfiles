{ lib, inputs, nixpkgs, ... }:
let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  test = lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit inputs pkgs;
    };

    modules = [
      ./configuration.nix
    ];
  };
}
