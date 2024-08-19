{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    mkHost = {
      hostname,
      username,
      nixpkgs ? inputs.nixpkgs,
      system ? "x86_64-linux",
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self inputs hostname username;
        };

        modules = with inputs;
          [
            ../modules/core

            home-manager.nixosModules.home-manager
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
          ]
          ++ extraModules;
      };
  in {
    wsl = mkHost {
      hostname = "wsl";
      username = "soriphoono";

      extraModules = with inputs; [
        ./wsl

        nixos-wsl.nixosModules.default
      ];
    };
  };
}
