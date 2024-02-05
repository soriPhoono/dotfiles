{ lib, inputs, nixpkgs, nixos-hardware, home-manager, nur, nixvim, hyprland, vars, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  home_desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system hyprland vars;
      host = {
        hostName = "home_desktop";
      };
    };
    modules = [
      nur.nixosModules.nur
      nixvim.nixosModules.nixvim
      # ./home_desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${vars.user} = {
          imports = [(import ./home.nix)]; # Include the core user's home.nix
        };
      }
    ];
  };
}
