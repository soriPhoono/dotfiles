{
  description = "Personal system configurations for home computers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";


  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
    in
    {
      templates = import ./templates;

      nixosModules.default.imports = [
        ./modules/nixos
      ];

      nixosSystems = {
        wsl = lib.nixosSystem {

        };
      };
    };
}
