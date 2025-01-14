{
  description = "Personal system configurations for home computers";

  inputs = {
    # Technical inputs
    systems.url = "github:nix-systems/default";

    # Repo inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Compiler inputs
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System inputs
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Global imports
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, ... }:
  let
    lib = nixpkgs.lib.extend (
      final: prev: (import ./lib {
        inherit self inputs;
        inherit (nixpkgs) lib;
      })
    );

    forAllSystems = action: lib.genAttrs (import inputs.systems) (system: action system);

    pkgs = forAllSystems (system: import nixpkgs {
      inherit system;

      overlays = import ./overlays;

      config.allowUnfree = true;
    });

    pkgsForAllSystems = action: forAllSystems (system: action pkgs.${system});
  in {
    templates = import ./templates;

    packages = import ./packages;

    formatter = pkgsForAllSystems (pkgs: pkgs.alejandra);

    nixosConfigurations = import ./systems {
      inherit self inputs;
      inherit (nixpkgs) lib;
    };
  } // (import ./modules);
}
