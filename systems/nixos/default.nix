{
  self,
  inputs,
  lib,
  ...
}: let
  mkSystem = {
    hostname,
    systems ? ["x86_64-linux" "x86_64-darwin"],
    users ? ["soriphoono"],
  }:
    lib.soriphoono.forSelectSystems systems (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;

          overlays = ../../overlays;

          config.allowUnfree = true;
        };
      in
      lib.nixosSystem{
        inherit system;

        specialArgs = {
          inherit self inputs pkgs hostname;
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
      });
in {
  wsl = mkSystem {
    hostname = "wsl";
  };
}
