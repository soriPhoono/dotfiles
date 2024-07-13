{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
in {
  zephyrus =
    let
      system = "x86_64-linux";
    
      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };

    in lib.nixosSystem {
      inherit system;
    
      specialArgs = { inherit lib inputs pkgs; };

      modules = [
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401

        ./zephyrus

        inputs.home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = { inherit inputs pkgs; };

            backupFileExtension = "~";

            users.soriphoono.imports = [
              ../users/soriphoono.nix
            ];
          };
        }
      ];
    };

    
    home-desktop =
    let
      system = "x86_64-linux";
    
      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
      };
    in lib.nixosSystem {
      inherit system;
    
      specialArgs = { inherit inputs pkgs; };
      
      modules = [
        ./zephyrus

        inputs.home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = { inherit inputs pkgs; };

            backupFileExtension = "~";

            users.soriphoono.imports = [
              ../users/soriphoono.nix
            ];
          };
        }
      ];
    };
}
