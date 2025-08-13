{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./containers/caddy-tailscale.nix
    ./containers/homepage-dashboard.nix

    ./containers/postgresql.nix
    ./containers/redis.nix

    ./containers/linkwarden.nix
    ./containers/nextcloud.nix

    ./containers/deluge.nix
    ./containers/qbittorrent.nix

    ./containers/prowlarr.nix

    ./containers/sonarr.nix
    ./containers/radarr.nix
    ./containers/jellyseerr.nix

    ./containers/lidarr.nix

    ./containers/readarr.nix

    ./containers/jellyfin.nix
    ./containers/navidrome.nix

    ./containers/ollama.nix
    ./containers/searxng.nix
    ./containers/open-webui.nix

    ./features/office.nix
    ./features/multimedia.nix
    ./features/development.nix
  ];

  options.server = with lib; {
    enable = mkEnableOption "Enable server config";

    networks = mkOption {
      type = with types; listOf str;
      default = [];
      description = "The server networks to create for feature coordination";
      example = [
        "server_net"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = {
      create-docker-networks = {
        description = "Create docker networks for server";
        wantedBy = ["multi-user.target"];
        after = ["docker.service"];
        requires = ["docker.service"];

        serviceConfig = {
          Type = "oneshot";
        };

        path = with pkgs; [
          docker
        ];

        script = builtins.concatStringsSep "\n" (map (name: ''
            if ! docker network ls | grep ${name}; then
              docker network create ${name}
            fi
          '')
          cfg.networks);
      };
    };

    virtualisation.oci-containers = {
      backend = "docker";
      containers.watchtower = {
        image = "containrrr/watchtower";

        environment = {
          WATCHTOWER_CLEANUP = "true";
          WATCHTOWER_POLL_INTERVAL = "3600";
          WATCHTOWER_LABEL_ENABLE = "true";
          WATCHTOWER_DEBUG = "true";
          WATCHTOWER_NOTIFICATIONS = "email";
          WATCHTOWER_NOTIFICATION_EMAIL_FROM = "admin@example.com";
          WATCHTOWER_NOTIFICATION_EMAIL_TO = "notify@example.com";
          WATCHTOWER_NOTIFICATION_EMAIL_SERVER = "smtp.gmail.com";
          WATCHTOWER_NOTIFICATION_EMAIL_SERVER_PORT = "587";
          WATCHTOWER_NOTIFICATION_EMAIL_USERNAME = "your_email_username";
          WATCHTOWER_NOTIFICATION_EMAIL_PASSWORD = "your_email_password";
        };

        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
        ];

        ports = [
          "8080:8080"
        ];
      };
    };

    server.containers = {
      caddy-tailscale = {
        enable = true;
        blocks = [
          ''
            https://home.xerus-augmented.ts.net {
              bind tailscale/home

              reverse_proxy localhost:8060
            }
          ''
        ];
      };
      homepage-dashboard.enable = true;
    };
  };
}
