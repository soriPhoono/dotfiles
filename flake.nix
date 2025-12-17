{
  description = "A system flake for my homelab and personal devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    system-manager = {
      url = "github:numtide/system-manager";
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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    system-manager,
    snowfall,
    ...
  }:
    (let
      lib = snowfall.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          meta = {
            name = "homelab";
            title = "Homelab and Personal Devices Configuration";
          };
          namespace = "soriphoono";
        };
      };
    in
      lib.mkFlake {
        inherit inputs;

        src = ./.;

        systems = {
          modules.nixos = with inputs; [
            nixos-facter-modules.nixosModules.facter
            disko.nixosModules.disko
            lanzaboote.nixosModules.lanzaboote
            sops-nix.nixosModules.sops
            nix-index-database.nixosModules.nix-index
          ];
        };

        homes = {
          modules = with inputs; [
            sops-nix.homeManagerModules.sops
            nvf.homeManagerModules.default
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
      })
    // (flake-utils.lib.eachDefaultSystemPassThrough (system: let
      lib = inputs.nixpkgs.lib;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      systemConfigurations = let
        mkSystem =
          name: system-manager.lib.makeSystemConfig {
            modules = (
              builtins.attrValues
                (lib.mapAttrs
                  (name: _: import ./modules/environments/${name}/default.nix { inherit pkgs; })
                  (lib.filterAttrs
                    (name: type: type == "directory" && (builtins.pathExists
                      ./modules/environments/${name}/default.nix))
                    (builtins.readDir ./modules/environments)))
            ) ++ [
              ./environments/${name}/default.nix
            ];
          };
      in (lib.mapAttrs
          (name: _: mkSystem name)
          (lib.filterAttrs
            (name: type: type == "directory" && (builtins.pathExists
              ./environments/${name}/default.nix))
            (builtins.readDir ./environments)))
        // (lib.mapAttrs
          (name: _: mkSystem name)
          (lib.filterAttrs
            (name: type: type == "directory" && (builtins.pathExists
              ./environments/${name}/default.nix))
            (builtins.readDir ./environments)));
    }));
}
