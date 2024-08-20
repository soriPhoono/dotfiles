{ self
, inputs
, ...
}: {
  flake.nixosConfigurations =
    let
      mkHost =
        { hostname
        , username
        , nixpkgs ? inputs.nixpkgs
        , system ? "x86_64-linux"
        , defaultModules ? true
        , extraModules ? [ ]
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit self inputs username;
          };

          modules = with inputs;
            [
              { networking.hostName = "${hostname}"; }

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
            ++ nixpkgs.lib.optionals defaultModules [
              self.nixosModules.default
            ] ++ extraModules;
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        defaultModules = false;

        extraModules = with inputs; [
          ./wsl

          nixos-wsl.nixosModules.default
        ];
      };
    };
}
