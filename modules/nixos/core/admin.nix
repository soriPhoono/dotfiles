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

      getName = token: lib.elemAt (lib.splitString "/" token) 0;
    in
      lib.genAttrs
      (map (name: "${name}/password") cfg.users)
      (name: {
        inherit sopsFile;

        neededForUsers = true;
      })
      // lib.genAttrs
      (map (name: "${name}/age_key") cfg.users)
      (name: let
        username = getName name;
      in {
        inherit sopsFile;

        path = "/home/${username}/.config/sops/age/keys.txt";

        mode = "0440";
        owner = username;
        group = "users";
      });

    snowfallorg.users = lib.genAttrs cfg.users (name: {});

    users.users = lib.genAttrs cfg.users (name: {hashedPasswordFile = config.sops.secrets."${name}/password".path;});
  };
}
