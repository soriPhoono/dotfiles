{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.mariadb;
in
  with lib; {
    options.server.containers.mariadb = {
      enable = mkEnableOption "Enable mariadb database for relational data operations";

      users = mkOption {
        type = with types; attrsOf str;
        description = "Users to create along with the default database they should control";
        example = {
          nextcloud = "nextcloud";
        };
      };
    };

    config = mkIf cfg.enable {
      sops = {
        secrets =
          (
            genAttrs
            (mapAttrsToList (name: username: "server/mariadb/users/${name}_password") cfg.users)
            (secret_name: {
              group = "docker";
            })
          )
          // {
            "server/mariadb/root_password" = {};
          };

        templates = {
          "mariadb.env".content = ''
            MARIADB_ROOT_PASSWORD=${config.sops.placeholder."server/mariadb/root_password"}
          '';
          "init.sql" = {
            content =
              builtins.concatStringsSep
              "\n"
              (mapAttrsToList (name: username: ''
                  CREATE DATABASE ${name};
                  CREATE USER '${username}'@'%' IDENTIFIED BY '${config.sops.placeholder."server/mariadb/users/${name}_password"}';
                  GRANT ALL PRIVILEGES ON ${name}.* TO '${username}'@'%';
                '')
                cfg.users);
            mode = "0644";
          };
        };
      };

      virtualisation.oci-containers.containers = {
        mariadb = {
          image = "mariadb:latest";

          environmentFiles = [
            config.sops.templates."mariadb.env".path
          ];

          volumes = [
            "${config.sops.templates."init.sql".path}:/docker-entrypoint-initdb.d/init.sql:ro"
            "/mnt/data/mariadb/:/var/lib/mysql/"
          ];

          networks = [
            "office_network"
          ];
        };
      };
    };
  }
