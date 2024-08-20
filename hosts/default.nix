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

              self.nixosModules.default

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
            ] ++ extraModules;
        };
    in
    {
      wsl = mkHost {
        hostname = "wsl";
        username = "soriphoono";

        extraModules = with inputs; [
          nixos-wsl.nixosModules.default

          ./wsl
        ];
      };
    };
}
