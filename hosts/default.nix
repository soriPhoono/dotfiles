{ self, inputs, ... }: {
  flake.nixosConfigurations = let
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

                sharedModules = [ self.homeManagerModules.default ];
                extraSpecialArgs = { inherit inputs username; };

                users.${username} = ../homes/${username}_${hostname};
              };
            }

            self.nixosModules.default
          ] ++ systemModules;
      };
  in {
    wsl = mkHost {
      hostname = "wsl";
      username = "soriphoono";

      systemModules = [ ./wsl ];
    };

    zephyrus = mkHost {
      hostname = "zephyrus";
      username = "soriphoono";

      systemModules = [ ./zephyrus ];
    };
  };
}
