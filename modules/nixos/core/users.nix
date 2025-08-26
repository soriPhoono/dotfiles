{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core;
in {
  options.core.users = with lib;
    mkOption {
      type = with types;
        attrsOf (submodule {
          options = {
            hashedPassword = mkOption {
              type = str;
              description = "The password hash for the user";
              example = "$6$N9zTq2VII1RiqgFr$IO8lxVRPfDPoDs3qZIqlUtfhtLxx/iNO47hUcx2zbDGHZsw..1sy5k.6.HIxpwkAhDPI7jZnTXKaIKqwiSWZA0";
            };

            admin = mkOption {
              type = bool;
              default = false;
              description = "Whether the user should have admin privileges.";
              example = true;
            };

            extraGroups = mkOption {
              type = listOf str;
              default = [];
              description = "Additional groups the user should belong to.";
              example = ["wheel" "docker"];
            };

            shell = with pkgs;
              mkOption {
                type = package;
                default = bashInteractive;
                description = "The shell for the user.";
                example = zsh;
              };

            publicKey = mkOption {
              type = nullOr str;
              default = null;
              description = "The public key for the user.";
              example = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC...";
            };
          };
        });

      description = "List of users to create.";

      example = {
        john = {
          admin = true;
        };
      };
    };

  config = {
    programs = {
      fish.enable = lib.any (user: user.shell == pkgs.fish) (builtins.attrValues cfg.users);
    };

    snowfallorg.users =
      builtins.mapAttrs (_: user: {
        inherit (user) admin;
      })
      cfg.users;

    users = {
      mutableUsers = false;

      extraUsers = builtins.mapAttrs (_: user: let
        adminKeys = if !user.admin (lib.mapAttrsToList (_: admin: admin.publicKey) (lib.filterAttrs (_: user: user.admin) cfg.users)) else [];
      in {
        inherit (user) hashedPassword extraGroups shell;

        openssh.authorizedKeys.keys =
          lib.mkIf (user.publicKey != null) ([user.publicKey] 
            ++ (adminKeys);
      })
      cfg.users;
    };

    home-manager.users =
      builtins.mapAttrs (_: user: {
        core = {
          ssh.publicKey = lib.mkIf (user.publicKey != null) user.publicKey;

          shells.fish.enable = user.shell == pkgs.fish;
        };
      })
      cfg.users;
  };
}
