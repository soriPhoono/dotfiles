{
  description = "Personal system configurations for home computers";

  inputs = {
    # Technical inputs
    systems.url = "github:nix-systems/default";

    flake-utils.url = "github:numtide/flake-utils";

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
    flake-utils,
    nixpkgs,
    nixos-generators,
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
          loadCompilable {
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
      // {
        templates =
          if builtins.pathExists ./templates
          then
            load (dirsOf ./templates) (name: {
              path = ./templates/${name};
              description = "Create boilerplate for a ${name} based project";
            })
          else {};

        nixosConfigurations = import ./systems {
          inherit self inputs lib;
        };
      }
      // lib.genAttrs
      [
        "nixosModules"
        "homeModules"
      ]
      (
        name: let
          modules = loadModules ./modules/${lib.removeSuffix "Modules" name};
        in
          modules
          // (
            if !(builtins.hasAttr "default" modules)
            then {
              default = {
                imports = builtins.attrValues self.${name};
              };
            }
            else {}
          )
      );
}
