{ lib, config, ... }:
let
  cfg = config.core.admin;
in
{
  options.core.admin = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Real name of the user";

      default = "Sori Phoono";
    };
  };

  config = {
    users = {
      users.${lib.soriphoono.to_unix_name cfg.name} = {
        description = cfg.name;
        initialPassword = "password";

        extraGroups = [ "wheel" ];

        isNormalUser = true;
      };
    };
  };
}
