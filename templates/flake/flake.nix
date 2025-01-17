{
  description = "Personal system configurations for home computers";

  inputs = {
    # Technical inputs
    flake-utils.url = "github:numtide/flake-utils";

    # Repo inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    flake-utils,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib.extend (final: prev:
      import ./lib {
        lib = prev;
      });
  in
    with lib.soriphoono;
      flake-utils.lib.eachDefaultSystem (system: let
        pkgs = nixpkgs.legacyPackages.${system};

        load = path:
          loadForSystem {
            inherit system path;

            args = {
              inherit lib pkgs;
            };
          };
      in {
        formatter = pkgs.alejandra;
        packages = load ./packages;
        devShells = load ./shells;
      })
      // flake-utils.lib.eachDefaultSystemPassThrough (system: {
        templates = load (builtins.readDir ./templates) (name: {
          path = ./templates/${name}.nix;

          description = "Create boilerplate for ${name}"; # TODO: allow for reading from file for description?
        });

        nixosModules = import ./modules/nixos;
        homeModules = import ./modules/home;

        nixosConfigurations = import ./systems {
          inherit self inputs lib;
        };

        homeConfigurations = import ./homes {
          inherit self inputs lib;
        };
      });
}
