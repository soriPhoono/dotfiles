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
    security.sudo.wheelNeedsPassword = false;

    sops.secrets = {
      admin_password.neededForUsers = true;
      admin_age_key = {
        path = "/home/${unix_name}/.config/sops/age/keys.txt";
        mode = "0440";
        owner = unix_name;
        group = "users";
      };
    };

    snowfallorg.users.${unix_name} = {};

    users.users.${unix_name} = {
      description = cfg.name;
      hashedPasswordFile = config.sops.secrets.admin_password.path;
    };
  };
}
