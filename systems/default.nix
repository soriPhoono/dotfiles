{
  self,
  inputs,
  lib,
  ...
}: let
  mkModules = {
    hostname,
    users ? ["soriphoono"],
  }: [
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

  mkSystem = {
    hostname,
    system ? "x86_64-linux",
    users ? ["soriphoono"],
  }:
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit self inputs hostname;
      };

      modules = mkModules {
        inherit hostname users;
      };
    };

  mkGenerator = {
    hostname,
    format,
    system ? "x86_64-linux",
    users ? ["soriphoono"],
  }:
    inputs.nixos-generators.nixosGenerate {
      inherit system format;

      specialArgs = {
        inherit self inputs hostname;
      };

      modules =
        (mkModules {
          inherit hostname users;
        })
        ++ [
          {
            virtualisation.virtualbox.guest.enable = hostname == "virtualbox";
          }
        ];
    };
in {
  wsl = mkSystem {
    hostname = "wsl";
  };
}
