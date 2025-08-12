{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.postgresql;
in
  with lib; {
    options.server.containers.postgresql = {
      enable = mkEnableOption "Enable postgresql database for relational data operations";

      users = mkOption {
        type = with types; attrsOf str;
        default = {};
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
            (mapAttrsToList (name: username: "server/postgresql/users/${name}_password") cfg.users)
            (secret_name: {
              group = "docker";
            })
          )
          // {
            "server/postgresql/root_password" = {};
          };

        templates = {
          "postgresql.env".content = ''
            POSTGRES_PASSWORD=${config.sops.placeholder."server/postgresql/root_password"}
          '';
          "init.sql" = {
            content =
              builtins.concatStringsSep
              "\n"
              (mapAttrsToList (name: username: ''
                  CREATE DATABASE ${name};
                  CREATE USER ${username} WITH PASSWORD '${config.sops.placeholder."server/postgresql/users/${name}_password"}';
                  GRANT ALL PRIVILEGES ON ${name} TO ${username};
                '')
                cfg.users);
            mode = "0644";
          };
        };
      };

      virtualisation.oci-containers.containers = {
        postgresql = {
          image = "postgres:14";

          environmentFiles = [
            config.sops.templates."postgresql.env".path
          ];

          volumes = [
            "${config.sops.templates."init.sql".path}:/docker-entrypoint-initdb.d/init.sql:ro"
            "/mnt/data/postgresql/:/var/lib/postgresql/data/"
          ];

          networks = [
            "multimedia_network"
            "office_network"
          ];
        };
      };
    };
  }
