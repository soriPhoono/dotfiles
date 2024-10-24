{ self, inputs, ... }: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs) lib;

      mkHost =
        { hostname, username, systemModules ? [ ], system ? "x86_64-linux" }:
        lib.nixosSystem {
          inherit system;

          specialArgs = { inherit self inputs lib username; };

          modules = with inputs;
            [
              { networking.hostName = "${hostname}"; }

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  backupFileExtension = "~";

                  sharedModules = [
                    inputs.plasma-manager.homeManagerModules.plasma-manager

                    self.homeManagerModules.default
                  ];
                  extraSpecialArgs = { inherit inputs username; };

                  users.${username} = ./homes/${hostname};
                };
              }

              self.nixosModules.default
            ] ++ systemModules;
        };
    in
    {
      zephyrus = mkHost {
        hostname = "zephyrus";
        username = "soriphoono";

        systemModules = [ ./nixos/zephyrus ];
      };

      desktop = mkHost {
        hostname = "desktop";
        username = "soriphoono";

        systemModules = [ ./nixos/desktop ];
      };
    };
}
