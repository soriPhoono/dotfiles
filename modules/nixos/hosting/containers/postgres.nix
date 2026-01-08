{
  lib,
  config,
  ...
}: let
  cfg = config.hosting.containers.postgres;
in
  with lib; {
    options.hosting.containers.postgres = {
      enable = mkEnableOption "Enable the automatic management of a postgresql instance";
    };

    config = let
      requestedNetworks = [
        "data_postgres-public"
      ];
    in
      mkIf cfg.enable {
        sops = {
          secrets = {
            "hosting/postgres/admin_password" = {};
          };
          templates = {
            "docker_postgres.env".content = ''
              POSTGRES_PASSWORD=${config.sops.placeholder."hosting/postgres/admin_password"}
            '';
          };
        };

        hosting.networks = requestedNetworks;

        virtualisation.oci-containers.containers = {
          data_postgres-database = {
            image = "postgres:18";
            volumes = [
              "data_postgres-data:/var/lib/postgresql"
            ];
            environmentFiles = [
              config.sops.templates."docker_postgres.env".path
            ];
            networks = requestedNetworks;
          };
        };
      };
  }
