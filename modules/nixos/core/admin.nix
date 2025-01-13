{ lib, config, ... }:
let
  this = "core.admin";

  cfg = config."${this}";
in
{
  options."${this}" = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Real name of the user";

      default = "Sori Phoono";
    };
  };

  config = {
    users =
      let
        to_unix_name =
          with lib;
          with lib.strings;
          name: (concatStrings (splitString " " (toLower name)));
      in
      {
        users.${to_unix_name cfg.name} = {
          description = cfg.name;
          initialPassword = "password";

          extraGroups = [ "wheel" ];

          isNormalUser = true;
        };
      };
  };
}
