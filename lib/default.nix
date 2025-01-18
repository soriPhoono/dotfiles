{ lib, ... }: {
  to_unix_name = name: with lib; with lib.strings; concatStrings (splitString " " (toLower name));
}
