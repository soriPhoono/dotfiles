{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting.docker;
in
  with lib; {
    options.hosting.docker = {
      enable = mkEnableOption "Enable Docker hosting support.";

      portainerDeploymentMode = mkOption {
        type = with types; nullOr (enum ["server" "agent"]);
        default = null;
        description = ''
          Deployment mode for Portainer. If set to "agent", Portainer will be
          deployed in agent mode, otherwise in server mode. If null, Portainer will not be
          deployed. Default: null.
        '';
      };

      domainName = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Domain name to use for accessing Portainer. Only relevant if
          portainerDeploymentMode is set. Default: "example.com".
        '';
        example = "mydomain.com";
      };
    };

    config = mkIf cfg.enable {
      sops = {
        secrets = {
          "hosting/cf_dns_api_token" = {};
        };
        templates."traefik.env".content = ''
          CLOUDFLARE_DNS_API_TOKEN=${config.sops.placeholder."hosting/cf_dns_api_token"}
        '';
      };

      virtualisation = {
        docker = {
          enable = true;
          autoPrune.enable = true;
        };

        oci-containers = {
          backend = "docker";

          containers = {
            watchtower = mkIf (cfg.portainerDeploymentMode != null) {
              image = "containrrr/watchtower:1.7.1";
              cmd = [
                "--cleanup"
                "--interval"
                "300"
              ];
              volumes = [
                "/var/run/docker.sock:/var/run/docker.sock"
              ];
            };
            traefik = mkIf (cfg.portainerDeploymentMode == "server") {
              image = "traefik:3.6";
              cmd = [
                "--entrypoints.web.address=:80"
                "--entrypoints.websecure.address=:443"
                "--entrypoints.websecure.transport.respondingTimeouts.readTimeout=24h"
                "--entrypoints.websecure.http.tls=true"
                "--entrypoints.traefik.address=:8080" # For the dashboard/API

                "--providers.docker=true"
                "--providers.docker.exposedbydefault=false"
                "--providers.docker.network=core_traefik-public"

                "--api.dashboard=true"
                "--api.insecure=false" # WARNING: Do not use in production without proper BasicAuth middleware

                "--certificatesresolvers.le-ts.acme.email=admin@${cfg.domainName}"
                "--certificatesresolvers.le-ts.acme.storage=/acme/acme.json"
                "--certificatesresolvers.le-ts.acme.dnschallenge=true"
                "--certificatesresolvers.le-ts.acme.dnschallenge.provider=cloudflare"

                "--log.level=INFO" # Set the Log Level e.g INFO, DEBUG
                "--accesslog=true" # Enable Access Logs
                "--metrics.prometheus=true" # Enable Prometheus

                "--entrypoints.web.http.redirections.entrypoint.to=websecure"
                "--entrypoints.web.http.redirections.entrypoint.scheme=https"
                "--entrypoints.web.http.redirections.entrypoint.permanent=true"
              ];
              environmentFiles = [
                config.sops.templates."traefik.env".path
              ];
              volumes = [
                "/etc/localtime:/etc/localtime:ro"
                "/var/run/docker.sock:/var/run/docker.sock:ro"

                "core_traefik-certs:/acme"
              ];
              networks = [
                "core_traefik-public"
              ];
              ports = [
                "80:80"
                "443:443"
              ];
              labels = mkIf (cfg.domainName != null) {
                "traefik.enable" = "true";

                "traefik.http.routers.traefik.rule" = "Host(`dashboard.admin.ts.${cfg.domainName}`)";
                "traefik.http.routers.traefik.entrypoints" = "web";
                "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "websecure";
                "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto" = "https";
                "traefik.http.routers.traefik.middlewares" = "traefik-https-redirect";
                "traefik.http.routers.traefik-secure.rule" = "Host(`dashboard.admin.ts.${cfg.domainName}`)";
                "traefik.http.routers.traefik-secure.entrypoints" = "websecure";
                "traefik.http.routers.traefik-secure.tls" = "true";
                "traefik.http.routers.traefik-secure.tls.certresolver" = "le-ts";
                "traefik.http.routers.traefik-secure.service" = "api@internal";
                "traefik.http.middlewares.traefik-auth.basicauth.users" = "admin:$2y$05$/UrxciXCv1x57qFZhDwBLOT2FkMjn2JoLW4yoXmKbQgbawFB8AJkq";
                "traefik.http.routers.traefik-secure.middlewares" = "traefik-auth";
              };
            };
            portainer-agent =
              mkIf
              (builtins.any
                (mode: cfg.portainerDeploymentMode == mode)
                ["agent" "server"]) {
                image = "portainer/agent:lts";
                dependsOn = ["watchtower"];
                volumes = [
                  "/var/run/docker.sock:/var/run/docker.sock"
                ];
                networks = mkIf (cfg.portainerDeploymentMode == "server") [
                  "core_portainer-network"
                ];
                ports = mkIf (cfg.portainerDeploymentMode == "agent") [
                  "9001:9001"
                ];
              };
            portainer-server = mkIf (cfg.portainerDeploymentMode == "server") {
              image = "portainer/portainer-ce:lts";
              dependsOn = ["portainer-agent" "watchtower"];
              cmd = [
                "-H"
                "tcp://portainer-agent:9001"
                "--tlsskipverify"
              ];
              volumes = [
                "core_portainer-data:/data"
              ];
              networks = [
                "core_portainer-network"
                "core_traefik-public"
              ];
              labels = mkIf (cfg.domainName != null) {
                "traefik.enable" = "true";

                "traefik.http.routers.portainer.rule" = "Host(`admin.ts.${cfg.domainName}`)";
                "traefik.http.routers.portainer.entrypoints" = "websecure";
                "traefik.http.routers.portainer.tls" = "true";
                "traefik.http.routers.portainer.tls.certresolver" = "le-ts";
                "traefik.http.routers.portainer.tls.domains[0].main" = "admin.ts.${cfg.domainName}";
                "traefik.http.routers.portainer.tls.domains[0].sans" = "*.admin.ts.${cfg.domainName}";

                "traefik.http.services.portainer.loadbalancer.server.port" = "9000";
              };
            };
          };
        };
      };

      systemd.services = let
        precedence = {
          after = ["create-docker-networks.service"];
          requires = ["create-docker-networks.service"];
        };
      in {
        "docker-portainer-agent" = precedence;
        "docker-portainer-server" = precedence;
        "docker-traefik" = precedence;
        "create-docker-networks" = {
          description = "Create Docker networks";
          wantedBy = ["multi-user.target"];
          after = ["docker.service"];
          requires = ["docker.service"];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          script = ''
            ${lib.concatMapStringsSep "\n" (network: ''
                ${pkgs.docker}/bin/docker network inspect "${network}" &>/dev/null || ${pkgs.docker}/bin/docker network create "${network}"
              '')
              [
                "core_portainer-network"
                "core_traefik-public"
              ]}
          '';
        };
      };

      users.extraUsers =
        builtins.mapAttrs (name: user: {
          extraGroups = [
            "docker"
          ];
        })
        (filterAttrs
          (name: content: content.admin)
          config.core.users);
    };
  }
