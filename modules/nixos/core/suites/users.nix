{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.suites.users;
in {
  options.core.suites.users = {
    users = let
      userType = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "User name to set for the user";
          };
          admin = lib.mkEnableOption "Enable admin for the user";
          groups = lib.mkOption {
            type = with lib.types; listOf str;
            description = "Additional groups to add to the user";

            default = [];
          };
          shell = lib.mkOption {
            type = lib.types.package;
            description = "The package to use as the user's shell";

            default = pkgs.fish;
          };
          publicKey = lib.mkOption {
            type = lib.types.str;
            description = "The public key to use for authentication";
          };
        };
      };
    in
      lib.mkOption {
        type = lib.types.listOf userType;
        description = "Users to configure for interaction";

        default = [
          {
            name = "soriphoono";
            admin = true;
            publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
          }
        ];
      };
  };

  config = {
    # NOTE: This was so hard and I love it

    sops.secrets =
      (lib.listToAttrs (map (user: {
          name = "${user.name}/password";

          value = {
            neededForUsers = true;
          };
        })
        cfg.users))
      // (lib.listToAttrs (
        map (user: {
          name = "${user.name}/age_key";

          value = {
            inherit (config.users.extraUsers."${user.name}") group;

            path = "/tmp/${user.name}.key";

            mode = "0440";
            owner = user.name;
          };
        })
        cfg.users));

    snowfallorg.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          inherit (user) admin;
        };
      })
      cfg.users);

    users = {
      mutableUsers = false;

      extraUsers = lib.listToAttrs (map (user: {
          inherit (user) name;

          value = {
            inherit (user) shell;

            hashedPasswordFile = config.sops.secrets."${user.name}/password".path;

            extraGroups = user.groups;

            openssh.authorizedKeys.keys = [
              user.publicKey
            ];
          };
        })
        cfg.users);
    };

    programs = {
      dconf.enable = true;

      fish.enable = lib.any (user: user.shell == pkgs.fish) cfg.users;
    };
  };
}
