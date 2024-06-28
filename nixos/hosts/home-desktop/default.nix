{ system, inputs, pkgs, vars, stateVersion }:
let
  inherit (inputs.nixpkgs) lib;
in
lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit inputs pkgs vars stateVersion;
  };

  modules = [
    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "~";

        extraSpecialArgs = {
          inherit inputs pkgs vars stateVersion;
        };

        users.${vars.defaultUser} = {
          imports = [
            ../../users/${vars.defaultUser}.nix
            ./modules/kde.nix
          ];
        };
      };
    }
  ];
}
