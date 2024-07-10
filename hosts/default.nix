{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations =
  let
    inherit (inputs.nixpkgs) lib;

    modules = "${self}/modules";

    specialArgs = { inherit self inputs; };
  in {
    home-desktop = lib.nixosSystem {
      inherit specialArgs;

      modules = [
          "${modules}/system/desktop.nix"

          ./home-desktop
        ];
    };
  };
}
