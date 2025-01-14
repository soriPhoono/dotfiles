{
  description = "Personal system configurations for home computers";

  inputs = {
    # Technical inputs
    systems.url = "github:nix-systems/default";

    # Repo inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib.extend (
      final: prev: (import ./lib {
        inherit self inputs;
        inherit (nixpkgs) lib;
      })
    );

    systems = import ./systems {
      inherit self inputs lib;
    };
  in {
    templates = import ./templates;

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;

    packages =
      lib.soriphoono.forAllSystems
      (system: import ./packages);

    formatter =
      lib.soriphoono.forAllSystems
      (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = systems.bareMetal;
  };
}
