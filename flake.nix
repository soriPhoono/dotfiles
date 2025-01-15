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
    systems = import inputs.systems;

    lib = nixpkgs.lib.extend(final: prev: import ./lib {
      # Write lib parameters here
    });

    pkgs = {};

    getPkgs = system:
      if lib.attrsets.hasAttr system pkgs
      then pkgs.${system}
      else let pkgs = import nixpkgs {
        inherit system;

        overlays = import ./overlays {
          # Write overlay parameters here
        };

        config.allowUnfree = true;
      };
      in pkgs;

    forEach = elements: f:
      lib.genAttrs
      elements
      (item: f item);

    pkgsForAllSystems = f:
      forEach systems (system: f (getPkgs system));

    getImportableEntries = path: map (entry: builtins.substring 0 ((builtins.stringLength entry) - 4) entry) (
      lib.attrsets.mapAttrsToList
      (name: type: name)
      (lib.attrsets.filterAttrs
        (name: type: type == "file" && lib.strings.hasSuffix ".nix" name)
        (if builtins.pathExists path
          then builtins.readDir path
          else {})
      )
    );
  in {
    templates = import ./templates;

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;

    formatter = pkgsForAllSystems (pkgs: pkgs.alejandra);

    packages =
      (
        forEach
        systems
        (system: forEach (getImportableEntries ./packages) (package: import ./packages/${package}.nix {inherit lib; pkgs = getPkgs system;}))
      ) // (
        forEach
        systems
        (system: forEach (getImportableEntries ./packages/${system}) (package: import ./packages/${system}/${package}.nix {inherit lib; pkgs = getPkgs system;}))
      );

    devShells =
      (
        forEach
        systems
        (system: forEach (getImportableEntries ./shells) (shell: import ./shells/${shell}.nix { pkgs = getPkgs system; }))
      ) // (
        forEach
        systems
        (system: forEach (getImportableEntries ./shells/${system}) (shell: import ./shells/${system}/${shell}.nix { pkgs = getPkgs system; }))
      );

    nixosConfigurations = import ./systems {
      inherit self inputs lib;
    };
  };
}
