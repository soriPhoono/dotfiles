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
      users.jellyfin = {
        password_hash = "iaA1btDuuDOniXs4hjBDqvBJ8E9Fb310";
        email = "jellyfin@xerus-augmented.ts.net";
        groups = [
          "jellyfin_users"
          "jellyfin_admins"
        ];
      };

      groups = ["jellyfin_users" "jellyfin_admins"];

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
