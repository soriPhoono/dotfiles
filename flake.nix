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
      nixosModules.default.imports = [
        ./modules/nixos
      ];
    };
}
