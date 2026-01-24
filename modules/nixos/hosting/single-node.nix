{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.configuration.single-node;
in
  with lib; {
    imports = [
      ./backends/docker.nix
    ];

    options.hosting.configuration.single-node = {
      networks = mkOption {
        type = with types; listOf str;
        description = "The networks to create in the docker environment being created by this module";
        default = [];
        example = [
          "admin_traefik-public"
        ];
      };

      domainName = mkOption {
        type = types.str;
        description = "The domain name of this service runner, for creating primary service applications with which to build further infrastructure";
        default = null;
        example = "example.com";
      };

      portainerMode = mkOption {
        type = with types; nullOr (enum ["server" "agent" "edge-agent" "edge-agent-async"]);
        default = null;
        description = "The mode to deploy portainer agent/edge-agent, and a possible portainer server";
        example = "server";
      };
    };

    config = mkIf (config.hosting.mode == "single-node") {
      hosting.backend.docker.enable = true;

      sops = mkIf (cfg.domainName != null) {
        secrets = {
          "hosting/admin/cf_api_token" = {};
        };
        templates = {
          "docker_traefik.env".content = ''
            CLOUDFLARE_DNS_API_TOKEN=${config.sops.placeholder."hosting/admin/cf_api_token"}
          '';
        };
      };

      systemd.services =
        {
          docker-create-networks = {
            description = "Create networks required by core docker service layer";
            after = ["docker.service"];
            wantedBy = ["multi-user.target"];
            serviceConfig = {
              Type = "oneshot";
              ExecStart = "${pkgs.writeShellApplication {
                name = "docker-create-networks.sh";
                runtimeInputs = with pkgs; [
                  docker
                ];
                text =
                  builtins.concatStringsSep
                  "\n"
                  (
                    builtins.map
                    (network_name: ''
                      if ! docker network ls | grep "${network_name}"; then
                        docker network create ${network_name}
                      fi
                    '')
                    ((unique (flatten (mapAttrsToList
                      (_: container_config: container_config.networks)
                      config.virtualisation.oci-containers.containers)))
                    ++ cfg.networks)
                  );
              }}/bin/docker-create-networks.sh";
            };
          };
        }
        // (lib.genAttrs
          (lib.mapAttrsToList
            (_: container_config: container_config.serviceName)
            config.virtualisation.oci-containers.containers)
          (_serviceName: {
            after = ["docker-create-networks.service"];
          }));

      virtualisation.oci-containers.containers = {
        admin_portainer-agent = mkMerge [
          (mkIf ((cfg.portainerMode == "agent") || (cfg.portainerMode == "server")) {
            image = "portainer/agent:lts";
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock"
            ];
            networks = [
              "admin_portainer-agent"
            ];
          })
          (mkIf ((cfg.portainerMode == "edge-agent") || (cfg.portainerMode == "edge-agent-async")) {
            image = "portainer/agent:lts";
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock"
              "/var/lib/docker/volumes:/var/lib/docker/volumes"
              "/:/host"
              "admin_portainer-agent"
            ];
            environment = {
              EDGE = 1;
              EDGE_ID = "";
              EDGE_KEY = "";
              EDGE_INSECURE_POLL = 0; # TODO: change this after reading https://docs.portainer.io/advanced/edge-agent
            };
          })
        ];

        admin_portainer-server = mkIf (cfg.portainerMode == "server") {
          image = "portainer/portainer-ee:latest";
          dependsOn = [
            "admin_portainer-agent"
          ];
          cmd = [
            "-H"
            "tcp://admin_portainer-agent:9001"
            "--tlsskipverify"
          ];
          volumes = [
            "admin_portainer-data:/data"
          ];
          networks = [
            "admin_portainer-agent"
            "admin_traefik-public"
          ];
          labels = {
            "traefik.enable" = "true";
            "traefik.http.routers.portainer.rule" = "Host(`admin.ts.${cfg.domainName}`)";
            "traefik.http.routers.portainer.entrypoints" = "websecure";
            "traefik.http.routers.portainer.tls" = "true";
            "traefik.http.routers.portainer.tls.certresolver" = "cf-ts";
            "traefik.http.services.portainer.loadbalancer.server.port" = "9000";
          };
        };

        admin_traefik-proxy = mkIf (cfg.domainName != null) {
          image = "traefik:latest";
          cmd = [
            "--entrypoints.web.address=:80"
            "--entrypoints.websecure.address=:443"
            # - --entrypoints.websecure.transport.respondingTimeouts.readTimeout=24h # For nextcloud long uploads
            "--entrypoints.websecure.http.tls=true"
            "--entrypoints.traefik.address=:8080" # For the dashboard/API
            # Docker provider setup
            "--providers.docker=true"
            "--providers.docker.exposedbydefault=false"
            "--providers.docker.network=admin_traefik-public"
            # API and Dashboard
            "--api.dashboard=true"
            "--api.insecure=false" # WARNING: Do not use in production without proper BasicAuth middleware
            # TODO: Check this is working properly (TLS enabled on all domains not just cloudflare but tailscale custom endpoints on domain name as well)
            # ACME / Let's Encrypt setup (Optional)
            "--certificatesresolvers.cf-ts.acme.email=admin@${cfg.domainName}"
            "--certificatesresolvers.cf-ts.acme.storage=/acme/acme.json"
            "--certificatesresolvers.cf-ts.acme.dnschallenge=true"
            "--certificatesresolvers.cf-ts.acme.dnschallenge.provider=cloudflare"
            # Observability
            "--log.level=INFO" # Set the Log Level e.g INFO, DEBUG
            "--accesslog=true" # Enable Access Logs
            "--metrics.prometheus=true" # Enable Prometheus
            # Optional: Enable redirect middleware for all HTTP to HTTPS traffic
            "--entrypoints.web.http.redirections.entrypoint.to=websecure"
            "--entrypoints.web.http.redirections.entrypoint.scheme=https"
            "--entrypoints.web.http.redirections.entrypoint.permanent=true"
          ];
          environmentFiles = [
            config.sops.templates."docker_traefik.env".path
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock:ro"
            "admin_traefik-certs:/acme"
          ];
          networks = [
            "admin_traefik-public"
          ];
          ports = [
            "80:80"
            "443:443"
          ];
        };
      };
    };
  }
