{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  options.server.services.nextcloud = {
    enable = lib.mkEnableOption "Enable nextcloud backend services";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets =
      (lib.listToAttrs (map (user: {
          name = "nextcloud/${user.name}_password";
          value = {
          };
        })
        config.core.users))
      // {
        "nextcloud/admin_password" = {};
      };

    systemd = {
      services."nextcloud-setup" = {
        requires = [
          "postgresql.service"
        ];
        after = [
          "postgresql.service"
        ];
      };
    };

    services = {
      postgresql = {
        enable = true;
        dataDir = "/mnt/postgresql";
        ensureDatabases = [
          "nextcloud"
        ];
        ensureUsers = [
          {
            name = "nextcloud";
            ensureDBOwnership = true;
          }
        ];
      };

      postgresqlBackup = {
        enable = true;
        location = "/mnt/backup/postgresql";
        startAt = "*-*-* 23:15:00";
        databases = [
          "nextcloud"
        ];
      };

      nextcloud = {
        enable = true;

        https = true;
        package = pkgs.nextcloud31;
        hostName = "nextcloud.xerus-augmented.ts.net";
        home = "/mnt/nextcloud";
        maxUploadSize = "100G";

        configureRedis = true;

        database.createLocally = true;

        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
        };
        extraAppsEnable = true;

        config = {
          adminpassFile = config.sops.secrets."nextcloud/admin_password".path;
          dbtype = "pgsql";
        };

        phpOptions = {
          "opcache.interned_strings_buffer" = 16;
        };

        settings = let
          prot = "https";
          host = "workstation.xerus-augmented.ts.net";
          dir = "/nextcloud";
        in {
          overwriteprotocol = prot;
          overwritehost = host;
          overwritewebroot = dir;
          overwrite.cli.url = "${prot}://${host}${dir}/";
          htaccess.RewriteBase = dir;
          default_phone_region = "US";
          trusted_proxies = [
            "127.0.0.1"
          ];
          maintenance_window_start = "1";
          log_type = "file";
        };
      };

      caddy.virtualHosts = {
        "${config.services.nextcloud.hostName}" = {
          extraConfig = ''
            bind tailscale/nextcloud
            tailscale_auth
            reverse_proxy localhost:8080 {

            }
          '';
        };
      };
    };
  };
}
