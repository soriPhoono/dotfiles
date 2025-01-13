{ self, inputs, lib, ... }:
let
  mkSystem =
    { hostname
    , extraModules
    , system ? "x86_64-linux"
    , users ? [ "soriphoono" ]
    ,
    }:
    let
      specialArgs = {
        inherit self inputs hostname;
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = specialArgs;

      modules = [
        self.nixosModules.default

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = specialArgs;

            sharedModules = [
              self.homeModules.default
            ];

            users = lib.genAttrs users (name: ../homes/${name});
          };
        }
      ] ++ extraModules;
    };
in
{
  wsl = mkSystem {
    hostname = "wsl";
    extraModules = [
      ./wsl
    ];
  };
}
