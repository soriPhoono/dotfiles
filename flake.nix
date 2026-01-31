{
  description = "A system flake for my homelab and personal devices";

  inputs = {
    systems.url = "github:nix-systems/default";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*";
    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    github-actions-nix = {
      url = "github:synapdeck/github-actions-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    snowfall,
    ...
  }: let
    inherit (nixpkgs) lib;
  in
    with lib; let
      flake-parts-outputs = flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
        imports = with inputs; [
          treefmt-nix.flakeModule
          git-hooks-nix.flakeModule
          github-actions-nix.flakeModule
        ];
        systems = with inputs; import systems;
        perSystem = args @ {system, ...}: let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [];
            config.allowUnfree = true;
          };
        in {
          devShells.default = import ./shell.nix (args
            // {
              inherit pkgs;
            });
          treefmt = import ./treefmt.nix;
          pre-commit = import ./pre-commit.nix;
          githubActions = import ./actions.nix {inherit self lib;};
        };
      });

      snowfall-outputs =
        (snowfall.mkLib {
          inherit inputs;
          src = ./.;
          snowfall = {
            meta = {
              name = "homelab";
              title = "Homelab and Personal Devices Configuration";
            };
            namespace = "soriphoono";
          };
        }).mkFlake {
          inherit inputs;

          src = ./.;

          systems = {
            modules.nixos = with inputs; [
              nixos-facter-modules.nixosModules.facter
              disko.nixosModules.disko
              determinate.nixosModules.default
              lanzaboote.nixosModules.lanzaboote
              sops-nix.nixosModules.sops
              comin.nixosModules.comin
              nix-index-database.nixosModules.nix-index
            ];
          };

          homes = {
            modules = with inputs; [
              sops-nix.homeManagerModules.sops
              nvf.homeManagerModules.default
              caelestia-shell.homeManagerModules.default
            ];
          };

          channels-config = {
            allowUnfree = true;
          };

          templates = {
            empty.description = ''
              An empty flake with a basic flake.nix to support a devshell environment.
              Made with flake-parts and sensable defaults
            '';
          };
        };
    in
      # Use a shallow merge (//) for the top-level attribute set to avoid traversing
      # large configurations like nixosConfigurations, while surgically merging
      # smaller attribute sets like devShells.
      (flake-parts-outputs // snowfall-outputs)
      // {
        devShells = recursiveUpdate (flake-parts-outputs.devShells or {}) (snowfall-outputs.devShells or {});
        checks = recursiveUpdate (flake-parts-outputs.checks or {}) (snowfall-outputs.checks or {});
        packages = recursiveUpdate (flake-parts-outputs.packages or {}) (snowfall-outputs.packages or {});
        formatter = recursiveUpdate (flake-parts-outputs.formatter or {}) (snowfall-outputs.formatter or {});
      };
}
