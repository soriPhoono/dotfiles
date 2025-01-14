{
  self,
  inputs,
  lib,
  ...
}: {
  soriphoono = let
    systems = import inputs.systems;
  in rec {
    forAllSystems = action: lib.genAttrs systems (system: action system);
  };
}
