{ self, inputs, ... }: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    specialArgs = { inherit self inputs; };

    global_modules = with inputs; [
      nix-index-db.nixosModules.nix-index

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
  in {
    zephyrus = nixosSystem {
      inherit specialArgs;

      modules = global_modules ++ [
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401

        ./zephyrus
      ];
    };

    home-desktop = nixosSystem {
      inherit specialArgs;

      modules = global_modules ++ [ ./home-desktop ];
    };
  };
}
