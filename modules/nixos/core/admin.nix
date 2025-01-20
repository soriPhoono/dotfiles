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
      description = "Unix name of the user";

      default = "soriphoono";
    };
  };

  config = {
    security.sudo.wheelNeedsPassword = false;

    sops.secrets = {
      admin_password.neededForUsers = true;

      admin_age_key = {
        path = "/home/${cfg.name}/.config/sops/age/keys.txt";
        mode = "0440";
        owner = cfg.name;
        group = "users";
      };
    };

    snowfallorg.users.${cfg.name} = {};

    users.users.${cfg.name}.hashedPasswordFile = config.sops.secrets.admin_password.path;
  };
}
