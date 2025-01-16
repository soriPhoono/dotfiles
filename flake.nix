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

    lib = nixpkgs.lib.extend (final: prev:
      import ./lib {
        # Write lib parameters here
      });

    pkgsBySystem = {};

    getPkgs = system:
      if lib.attrsets.hasAttr system pkgsBySystem
      then pkgsBySystem.${system}
      else let
        pkgs = import nixpkgs {
          inherit system;

          overlays = import ./overlays {
            # Write overlay parameters here
          };

          config.allowUnfree = true;
        };
      in
        pkgs;

    forEach = f: elements:
      lib.genAttrs
      elements
      (item: f item);

    forEachSystem = f: forEach f systems;

    pkgsForAllSystems = f:
      forEachSystem (system: f (getPkgs system));

    readIfExists = path:
      if builtins.pathExists path
      then builtins.readDir path
      else {};

    getFilesOfType = path: extension:
      lib.attrsets.filterAttrs
      (name: type: (type == "regular") && lib.strings.hasSuffix extension name)
      (readIfExists path);

    afterLastOf = sub: str:
      let
        elements = builtins.split sub str;
      in builtins.elemAt elements ((builtins.length elements) - 1);

    getFileNames = files:
      lib.attrsets.mapAttrsToList
        (name: type: afterLastOf "/" name)
        files;

    importSystem = path: system: let
      importFrom = path:
        forEach (entry: import ./${path}/${entry}.nix {
          inherit lib;

          pkgs = getPkgs system;
        }) (map (file: lib.strings.removeSuffix ".nix" file) (getFileNames (getFilesOfType path ".nix")));
    in
      (importFrom ./${path}) // (importFrom ./${path}/${system});
  in {
    templates = import ./templates;

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;

    formatter = pkgsForAllSystems (pkgs: pkgs.alejandra);

    packages = forEachSystem (system: importSystem ./packages system);

    devShells = forEachSystem (system: importSystem ./shells system);

    nixosConfigurations = import ./systems {
      inherit self inputs lib;
    };
  };
}
