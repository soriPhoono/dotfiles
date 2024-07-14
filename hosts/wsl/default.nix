{ lib, inputs, vars, ... }:
let
  system = "x86_64-linux";

  pkgs = import inputs.nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };
in lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit lib inputs pkgs vars;
  };

  modules = with inputs; [
    nixos-wsl.nixosModules.default

    ../configuration.nix
    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "~";

        extraSpecialArgs = { inherit inputs pkgs vars; };

        users.${vars.defaultUser} = {
          imports = [ ../../users/${vars.defaultUser}.nix ];
        };
      };
    }
  ];
}
