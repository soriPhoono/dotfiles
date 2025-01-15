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
    inherit (nixpkgs) lib;

    forEach = f: elem:
      lib.genAttrs
      elem
      (item: f item);

    mkPkgs = system:
      nixpkgs.legacyPackages.${system};

    forAllSystems = f:
      forEach f (import inputs.systems);

    pkgsForAllSystems = f:
      forAllSystems (system: f (mkPkgs system));

    readDirIfExists = path:
      if builtins.pathExists path
      then builtins.readDir path
      else {};

    getNixFilesAt = path:
      lib.attrsets.mapAttrsToList (name: type: name)
      (lib.filterAttrs
      (name: type: type == "file" && lib.strings.hasSuffix ".nix" name)
      (readDir path));

    # createDefaultEntry =
    #   path:
    #   args:
    #   if builtins.pathExists path
    #   then {
    #     (builtins.substring 0 ((builtins.stringLength path) - 4)) = import path args;
    #   }
    #   else {};

    getImportableEntries = path: map (package: builtins.substring 0 ((builtins.stringLength package) - 4) package) (read_nix_files path);
  in {
    templates = import ./templates;

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;

    formatter = pkgsForAllSystems (pkgs: pkgs.alejandra);

    packages =
      (
        if builtins.pathExists ./default.nix
        then forAllSystems (system: let pkgs = mkPkgs system; in {
          default = import ./default.nix {
            inherit lib pkgs;
          };
        })
        else {}
      ) // (
        forAllSystems
        (system: let
          pkgs = mkPkgs system;
        in forEach (package: import ./packages/${package}.nix {inherit lib pkgs;}) (getImportableEntries ./packages))
      ) // (
        forAllSystems
        (system: let
          pkgs = mkPkgs system;
        in forEach (package: import ./packages/${system}/${package}.nix {inherit lib pkgs;}) (getImportableEntries ./packages/${system}))
      );

    devShells =
      (
        if builtins.pathExists ./shell.nix
        then forAllSystems
        (system: let pkgs = mkPkgs system; in {
          default = import ./shell.nix {
            inherit pkgs;
          };
        })
        else {};
      ) // (
        forAllSystems
        (system: let
          pkgs = mkPkgs pkgs;
        in forEach (shell: import ./shells/${shell}.nix { inherit pkgs; }) (getImportableEntries ./shells))
      ) // (
        forAllSystems
        (system: let
          pkgs = mkPkgs pkgs;
        in forEach (shell: import ./shells/${system}/${shell}.nix {inherit pkgs; }) (getImportableEntries ./shells/${system}))
      )

    nixosConfigurations = import ./systems {
      inherit self inputs lib;
    };
  };
}
