{ lib, ... }: {
  real_to_unix_name =
    with lib;
    with lib.strings;
    name: (concatStrings (splitString " " (toLower name)));
}
