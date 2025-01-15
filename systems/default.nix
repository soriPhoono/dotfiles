{
  self,
  inputs,
  lib,
  ...
}: let
  mkSystem = {
    hostname,
    system ? "x86_64-linux",
    users ? ["soriphoono"],
  }:
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs lib hostname;
      };

      modules = [
        {
          networking.hostName = hostname;
        }

        self.nixosModules.default

        ./${hostname}

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit inputs;
            };

            sharedModules = [
              self.homeModules.default
            ];

            # TODO: see if we can set home config from homeConfigurations in the flake to preserve load configuration
            users = lib.genAttrs users (name: ../homes/${name});
          };
        }
      ];
    };
in {
  wsl = mkSystem {
    hostname = "wsl";
  };
}
