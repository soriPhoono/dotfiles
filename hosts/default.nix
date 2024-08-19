{ self, inputs, ... }: {
  flake.nixosConfigurations =
    let
      mkHost =
        { hostname
        , username
        , nixpkgs ? inputs.nixpkgs
        , system ? "x86_64-linux"
        , defaultModules ? true
        , hmEnable ? true
        , extraModules ? [ ]
        ,
        }: nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs username;
          };

          modules = [

          ] ++ nixpkgs.lib.optional hmEnable [
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = ".bak";

                extraSpecialArgs = {
                  inherit inputs;
                };

                users.${username} = ../homes/${username};
              };
            }
          ] ++ nixpkgs.lib.optional defaultModules [

          ] ++ extraModules;
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        defaultModules = false;

        extraModules = [
          ./wsl

          inputs.nixos-wsl.nixosModules.default
        ];
      };
    };
}
