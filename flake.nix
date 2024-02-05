{
  description = "Set of personal NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    # TODO: add home manager for personal rice
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit nixpkgs;
      }
    );
  };
}
