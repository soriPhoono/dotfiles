{ self, inputs, ... }: {
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs) lib;

      mkHost =
        { hostname, systemModules ? [ ], system ? "x86_64-linux" }:
        lib.nixosSystem {
          inherit system;

          specialArgs = { inherit self inputs lib; };

          modules = with inputs;
            [
              { networking.hostName = "${hostname}"; }

              self.nixosModules.default
            
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  sharedModules = [
                    self.homeManagerModules.default
                  ];

                  extraSpecialArgs = { inherit inputs; };

                  users = {
                    soriphoono = ./homes/${hostname}/soriphoono.nix;
                    # spookyskelly = lib.mkIf (hostname == "desktop") ./homes/desktop/spookyskelly.nix;
                  };
                };
              }
            ] ++ systemModules;
        };
    in
    {
      zephyrus = mkHost {
        hostname = "zephyrus";

        systemModules = [ ./nixos/zephyrus ];
      };

      desktop = mkHost {
        hostname = "desktop";

        systemModules = [ ./nixos/desktop ];
      };
    };
}
