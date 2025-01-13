{ self, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  mkSystem =
    details:
    let
      specialArgs = {
        inherit self inputs;
        inherit (details) hostname;
      };
    in
    lib.nixosSystem {
      inherit specialArgs;
      inherit (details) system;

      modules = [
        self.nixosModules.default

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            sharedModules = [
              self.homeModules.default
            ];

            extraSpecialArgs = specialArgs;

            users = lib.genAttrs ([ "soriphoono" ] ++ (details.users or [ ])) (name: ../homes/${name});
          };
        }
      ] ++ details.extraModules;
    };
in
{
  wsl = mkSystem {
    system = "x86_64-linux";

    hostname = "wsl";

    extraModules = [
      ./wsl
    ];
  };
}
