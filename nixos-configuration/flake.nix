{
  description = "Personal computer configurations";

  inputs = {
    # Core inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # User inputs
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";

      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Per system inputs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Desktop inputs
    stylix = {
      url = "github:danth/stylix";

      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs@ { nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations = {
      home-desktop = 
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";

          overlays = import ./overlays;

          config.allowUnfree = true;
        };

        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";

          overlays = import ./overlays;

          config.allowUnfree = true;
        };
      in {
        system = "x86_64-linux";

        specialArgs = { inherit inputs pkgs pkgs-unstable; };

        modules = [
          ./hosts/configuration.nix

          ./hosts/home-desktop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              backupFileExtension = "~";

              extraSpecialArgs = { inherit inputs pkgs pkgs-unstable; };

              users.soriphoono = {
                imports = [
                  ./home-manager/users/soriphoono.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
