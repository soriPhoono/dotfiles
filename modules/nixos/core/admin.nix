{
  lib,
  config,
  ...
}: let
  cfg = config.core.admin;
in {
  options.core.admin = {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Unix name of the user";

      default = ["soriphoono"];
    };
  };

  config = {
    security.sudo.wheelNeedsPassword = false;

    sops.secrets = let
      sopsFile = ../../../secrets/global.yaml;
    in
      lib.mapAttrs (name: {
        "${name}_password" = {
          inherit sopsFile;

          neededForUsers = true;
        };

        "${name}_age_key" = {
          inherit sopsFile;

          path = "/home/${name}/.config/sops/age/keys.txt";

          mode = "0440";
          owner = name;
          group = "users";
        };
      })
      config.snowfallorg.users;

    snowfallorg.users = lib.genAttrs (name: {}) cfg.users;

    users.users = lib.genAttrs (name: {hashedPasswordFile = config.sops.secrets."${name}_password".path;}) cfg.users;
  };
}
