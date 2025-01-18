{
  lib,
  config,
  ...
}: let
  cfg = config.core.admin;
in {
  options.core.admin = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Real name of the user";

      default = "Sori Phoono";
    };
  };

  config = let
    to_unix_name = with lib;
    with lib.strings;
      name: concatStrings (splitString " " (toLower name));
  in {
    snowfallorg.users.${to_unix_name cfg.name} = {};

    users = {
      users.${to_unix_name cfg.name} = {
        description = cfg.name;
        initialPassword = "password";
      };
    };
  };
}
