{ lib, nixpkgs, ... }:
let
  system = "x86_64-linux";

  lib = nixpkgs.lib;
in {
  test_vm = lib.nixosSystem {
    inherit system;
    modules = [
      ./vm
      ./configuration.nix
    ];
  };
}
