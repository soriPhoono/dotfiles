{ system, inputs, pkgs, vars }:
let inherit (inputs.nixpkgs) lib;
in lib.nixosSystem {
  inherit system;

  specialArgs = { inherit inputs pkgs vars; };

  modules = [
    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "~";

        extraSpecialArgs = { inherit inputs pkgs vars; };

        users.${vars.defaultUser} = {
          imports = [ ../../users/${vars.defaultUser}.nix ./modules/kde.nix ];
        };
      };
    }
  ];
}
