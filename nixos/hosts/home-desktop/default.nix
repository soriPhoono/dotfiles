{ system, inputs, pkgs, pkgs-unstable, vars }:
let inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  specialArgs = { inherit inputs pkgs pkgs-unstable vars; };

  modules = [
    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "~";

        extraSpecialArgs = { inherit inputs pkgs pkgs-unstable vars; };

        users.${vars.defaultUser} = {
          imports = [ ../../users/${vars.defaultUser}.nix ./modules/kde.nix ];
        };
      };
    }
  ];
}
