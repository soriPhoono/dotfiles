{ lib, inputs, ... }:
let
  system = "x86_64-linux";

  pkgs = import inputs.nixpkgs {
    inherit system;

    overlays = import ../../overlays.nix;

    config.allowUnfree = true;
  };

  inherit (import ../../users/common) cli;
in lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit lib inputs pkgs;
  };

  modules = with inputs; [
    nixos-wsl.nixosModules.default

    ../../modules

    ./configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = { inherit inputs pkgs; };

        users.soriphoono = {
          imports = cli ++ [
            ../../users/soriphoono.nix
          ];
        };
      };
    }
  ];
}
