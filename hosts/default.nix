{ self
, inputs
, ...
}: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs) lib;

      mkHost =
        { hostname
        , username
        , systemModule
        , nixpkgs ? inputs.nixpkgs
        , system ? "x86_64-linux"
        }:
        lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs lib username;
          };

          modules = with inputs;
            [
              { networking.hostName = "${hostname}"; }

              self.nixosModules.default

              systemModule

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  backupFileExtension = "~";

                  extraSpecialArgs = {
                    inherit inputs username;
                  };

                  users.${username} = ../homes/${username};
                };
              }
            ];
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        systemModule = ./wsl;
      };
      zephyrus = mkHost {
        hostname = "zephyrus";
        username = "soriphoono";

        systemModule = ./zephyrus;
      };
    };
}
