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
    unix_name = lib.dotfiles.to_unix_name cfg.name;
  in {
    snowfallorg.users.${unix_name} = {};

    users = {
      users.${unix_name} = {
        description = cfg.name;
        initialPassword = "password";
      };
    };
  };
}
