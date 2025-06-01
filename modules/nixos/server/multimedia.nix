{
  lib,
  config,
  ...
}: let
  cfg = config.server.multimedia;

  serviceDir = "/services/jellyfin/";
  dataDir = "/mnt/media";

  endpoint = "https://media.${config.core.networking.tailscale.tn_name}";
in {
  options.server.multimedia.enable = lib.mkEnableOption "Enable multimedia server";

  config = lib.mkIf cfg.enable {
    server = {
      users.multimedia = {
        password_hash = "{SSHA}kvNzS4CXHeLPGRewYEBCkinzvd5hYWZj";
        email = "multimedia@xerus-augmented.ts.net";
        groups = [
          "multimedia_users"
          "multimedia_admins"
        ];
      };

      groups = ["multimedia_users" "multimedia_admins"];

      ldap.enable = true;
      nextcloud.enable = true;
    };

    users.groups.multimedia.members = ["nextcloud" config.services.jellyfin.user];

    systemd.tmpfiles.rules = [
      "d ${dataDir} 755 nextcloud multimedia -"
      "d ${dataDir}/Shows/ 755 nextcloud multimedia -"
      "d ${dataDir}/Movies/ 755 nextcloud multimedia -"
      "d ${dataDir}/Music/ 755 nextcloud multimedia -"
    ];

    services = {
      jellyfin = {
        enable = true;

        dataDir = serviceDir;
      };

      caddy.virtualHosts = {
        ${endpoint} = {
          extraConfig = ''
            bind tailscale/media
            reverse_proxy localhost:8096
          '';
        };
      };

      homepage-dashboard.services = [
        {
          "Media" = [
            {
              "JellyFin" = {
                description = "JellyFin media server";
                href = endpoint;
              };
            }
          ];
        }
      ];
    };
  };
}
