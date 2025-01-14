{ self, inputs, lib, ... }:
let
  mkSystem =
    { hostname
    , system ? "x86_64-linux"
    , users ? [ "soriphoono" ]
    }:
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self inputs hostname;
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
              inherit self inputs hostname;
            };

            sharedModules = [
              self.homeModules.default
            ];

            users = lib.genAttrs users (name: ../homes/${name});
          };
        }
      ];
    };
in
{
  wsl = mkSystem {
    hostname = "wsl";
  };

  vbox =
    let
      hostname = "vbox";
    in
      inputs.nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "virtualbox";

        specialArgs = {
          inherit self inputs hostname;
        };

        modules = [
          {
            networking.hostName = hostname;
          }

          self.nixosModules.default

          ./${hostname}

          inputs.home-manager.nixosModules.home-manager{
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit self inputs hostname;
              };

              sharedModules = [
                self.homeModules.default
              ];

              users = lib.genAttrs ["soriphoono"] (name: ../homes/${name});
            };
          }
        ];
      };
}
