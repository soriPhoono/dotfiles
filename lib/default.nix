{ inputs, lib, ... }: {
  soriphoono = {
    forAllSystems = lib.genAttrs (import inputs.systems);

    to_unix_name =
      with lib;
      with lib.strings;
      name: concatStrings (splitString " " (toLower name));

    home = { };
  };
}
