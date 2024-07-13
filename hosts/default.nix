{ inputs, pkgs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  specialArgs = { inherit lib inputs pkgs; };

  hm = inputs.hm.nixosModules.home-manager {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = specialArgs;

      users.soriphoono = { imports = [ ../users/soriphoono.nix ]; };
    };
  };
in {
  flake.nixosConfigurations = {
    zephyrus = lib.nixosSystem {
      inherit specialArgs;

      modules = [
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401

        ./zephyrus

        hm
      ];
    };

    home-desktop = lib.nixosSystem {
      inherit specialArgs;
      modules = [ ./home-desktop hm ];
    };
  };
}
