{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    snowfall,
    ...
  }:
    snowfall.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall.namespace = "soriphoono";

      systems.modules.nixos = with inputs; [sops-nix.nixosModules.sops];

      templates = {module.description = "A very basic module entrypoint";};

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    };
}
