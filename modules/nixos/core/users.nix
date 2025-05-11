{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core;
in {
  options.${namespace}.core.users = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "The name of the user.";
          example = "john";
        };

        admin = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether the user should have admin privileges.";
          example = true;
        };

        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          description = "Additional groups the user should belong to.";
          example = ["wheel" "docker"];
        };

        shell = lib.mkOption {
          type = lib.types.package;
          default = pkgs.bashInteractive;
          description = "The shell for the user.";
          example = pkgs.zsh;
        };

        publicKey = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "The public key for the user.";
          example = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC...";
        };
      };
    });

    description = "List of users to create.";

    default = [
      {
        name = "soriphoono";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      }
    ];

    example = [
      {
        name = "john";
        admin = true;
      }
      {
        name = "jane";
        admin = false;
      }
    ];
  };

  config = {
    sops.secrets = lib.listToAttrs (map (user: {
        name = "${user.name}/password";
        value = {neededForUsers = true;};
      })
      cfg.users);

    snowfallorg.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {inherit (user) admin;};
      })
      cfg.users);

    users = {
      mutableUsers = false;

      extraUsers = lib.listToAttrs (map (user: {
          inherit (user) name;

          value = {
            inherit (user) extraGroups shell;

            initialPassword = lib.mkIf (!config.${namespace}.core.secrets.authorized) "password";
            hashedPasswordFile = lib.mkIf config.${namespace}.core.secrets.authorized config.sops.secrets."${user.name}/password".path;

            openssh.authorizedKeys.keys =
              lib.mkIf (user.publicKey != null) [user.publicKey];
          };
        })
        cfg.users);
    };

    programs = {
      fish.enable = lib.any (user: user.shell == pkgs.fish) cfg.users;
    };
  };
}
