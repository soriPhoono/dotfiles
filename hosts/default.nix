{ self, inputs, ... }: {
  flake.nixosConfigurations =
    let
      mkHost =
        { hostname
        , username
        , nixpkgs ? inputs.nixpkgs
        , system ? "x86_64-linux"
        , desktopModules ? true
        , serverModules ? false # For later
        , hmEnable ? true
        , extraModules ? [ ]
        }: nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs hostname username;
          };

          modules = with inputs; [
            ../modules/core

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "~";

                extraSpecialArgs = {
                  inherit inputs;
                };

                users.${username} = ../homes/${username};
              };
            }

            inputs.treefmt-nix.flakeModule
          ] ++ extraModules;
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        desktopModules = false;

        extraModules = [
          ./wsl

          inputs.nixos-wsl.nixosModules.default
        ];
      };
    };
}
