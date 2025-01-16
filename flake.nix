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

    forEach = elements: f:
      lib.genAttrs
      elements
      (item: f item);

    forEachSystem = forEach systems;

    pkgsForAllSystems = f:
      forEachSystem (system: f (getPkgs system));

    readIfExists = path:
      if builtins.pathExists path
      then builtins.readDir path
      else {};

    afterLastOf = sub: str: let
      elements = builtins.split sub str;
    in
      builtins.elemAt elements ((builtins.length elements) - 1);

    importSystem = path: system: let
      importFrom = path:
        forEach (map (entry: lib.strings.removeSuffix ".nix" entry) (
          lib.attrsets.mapAttrsToList
          (name: type: afterLastOf "/" name)
          (lib.attrsets.filterAttrs
            (name: type: (type == "regular") && lib.strings.hasSuffix ".nix" name)
            (readIfExists ./${path}))
        )) (entry: import ./${path}/${entry}.nix {
          inherit lib;

          pkgs = getPkgs system;
        });
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
