{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
  };

  outputs = inputs@{ self, nixpkgs, snowfall, ... }: snowfall.mkFlake {
    inherit inputs;

    src = ./.;

    channels-config.allowUnfree = true;

    templates = {
      module.description = "A very basic module entrypoint";
    };
  };
}
