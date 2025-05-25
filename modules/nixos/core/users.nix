{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core;
in {
  options.core.users = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "The name of the user.";
          example = "john";
        };

        email = lib.mkOption {
          type = lib.types.str;
          description = "The email of the user.";
          example = "john@doe.com";
        };

        hashedPassword = lib.mkOption {
          type = lib.types.str;
          description = "The password hash for the user";
          example = "$6$N9zTq2VII1RiqgFr$IO8lxVRPfDPoDs3qZIqlUtfhtLxx/iNO47hUcx2zbDGHZsw..1sy5k.6.HIxpwkAhDPI7jZnTXKaIKqwiSWZA0";
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
        email = "soriphoono@protonmail.com";
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
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
    programs = {
      fish.enable = lib.any (user: user.shell == pkgs.fish) cfg.users;
    };

    users = {
      mutableUsers = false;

      extraUsers = lib.listToAttrs (map (user: {
          inherit (user) name;

          value = {
            inherit (user) hashedPassword extraGroups shell;

            openssh.authorizedKeys.keys =
              lib.mkIf (user.publicKey != null) [user.publicKey];
          };
        })
        cfg.users);
    };

    snowfallorg.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {inherit (user) admin;};
      })
      cfg.users);

    home-manager.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          home.file.".ssh/id_ed25519.pub".text = user.publicKey;

          core = {
            ssh.publicKey = lib.mkIf (!(builtins.isNull user.publicKey)) user.publicKey;

            shells.fish.enable = user.shell == pkgs.fish;
          };
        };
      })
      cfg.users);
  };
}
