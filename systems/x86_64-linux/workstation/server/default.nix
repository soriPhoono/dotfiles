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
    
    ./containers/mariadb.nix
    ./containers/redis.nix
    ./containers/nextcloud.nix

    ./containers/deluge.nix
    ./containers/prowlarr.nix
    ./containers/sonarr.nix
    ./containers/radarr.nix
    ./containers/lidarr.nix
    ./containers/readarr.nix
    
    ./containers/jellyfin.nix
    ./containers/jellyseerr.nix

    ./features/multimedia.nix
    ./features/office.nix
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

    virtualisation.oci-containers.backend = "docker";

    server.containers.caddy-tailscale.enable = true;
  };
}
