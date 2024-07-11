{ self, inputs, ... }: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = { inherit self inputs; };
  in {
    home-desktop = nixosSystem {
      inherit specialArgs;

      modules = [
        ./home-desktop

        inputs.hm.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = specialArgs;

            users.soriphoono = { imports = [ ../users/soriphoono.nix ]; };
          };
        }
      ];
    };
  };
}
