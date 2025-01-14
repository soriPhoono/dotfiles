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
  in
    {
      templates = import ./templates;

      packages = import ./packages;

      formatter = lib.soriphoono.pkgsForAllSystems (pkgs: pkgs.alejandra);

      nixosConfigurations = import ./systems/nixos {
        inherit self inputs lib;
      };
    }
    // (import ./modules);
}
