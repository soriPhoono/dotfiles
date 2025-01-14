{
  self,
  inputs,
  lib,
  ...
}: {
  soriphoono = rec {
    forSelectSystems = systems: action: lib.genAttrs systems (system: action system);
    forAllSystems = action: lib.genAttrs (import inputs.systems) (system: action system);

    pkgs = forAllSystems (system:
      import inputs.nixpkgs {
        inherit system;

        overlays = import ../overlays;

        config.allowUnfree = true;
      });

    pkgsForAllSystems = action: forAllSystems (system: action pkgs.${system});
  };
}
