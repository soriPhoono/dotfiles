{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hosting;
in
  with lib; {
    imports = [
      ./podman.nix
      ./docker.nix
    ];

    options.hosting = {
      enable = mkEnableOption "Enable hosting platform for system, in either single-host or clustered mode";

      clusteredMode = mkEnableOption "Signify this machine as a member of a kubernetes cluster";

      domainName = mkOption {
        type = types.str;
        description = "The domain name of this service runner, for creating primary service applications with which to build further infrastructure";
        default = null;
        example = "What is the domain name of this service runner platform";
      };

      networks = mkOption {
        type = with types; listOf str;
        description = "The networks to create in the docker environment being created by this module";
        default = [];
        example = [
          "admin_traefik-public"
        ];
      };
    };

    config = mkIf (cfg.enable && !cfg.clusteredMode) {
      hosting.docker.enable = !config.hosting.podman.enable;

      sops = {
        secrets = {
          "hosting/cf_api_token" = {};
        };
        templates = {
          "traefik.env".content = ''
            CLOUDFLARE_DNS_API_TOKEN=${config.sops.placeholder."hosting/cf_api_token"}
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
                text = builtins.concatStringsSep "\n" (builtins.map (network_name: "docker network create ${network_name}") (cfg.networks));
              }}/bin/docker-create-networks.sh";
            };
          };
        }
        // (builtins.mapAttrs (container_name: container_config: {
            after = ["${container_config.serviceName}.service"];
          })
          config.virtualisation.oci-containers.containers);

      hosting.networks = [
        "admin_traefik-public"
      ];

      virtualisation.oci-containers.containers = {
        traefik = {
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
            config.sops.templates."traefik.env".path
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
          labels = {
            "traefik.enable" = "true";
            "traefik.http.routers.traefik.rule" = "Host(`dashboard.admin.ts.${cfg.domainName}`)";
            "traefik.http.routers.traefik.entrypoints" = "web";
            "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "websecure";
            "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto" = "https";
            "traefik.http.routers.traefik.middlewares" = "traefik-https-redirect";
            "traefik.http.routers.traefik-secure.rule" = "Host(`dashboard.admin.ts.${cfg.domainName}`)";
            "traefik.http.routers.traefik-secure.entrypoints" = "websecure";
            "traefik.http.routers.traefik-secure.tls" = "true";
            "traefik.http.routers.traefik-secure.tls.certresolver" = "cf-ts";
            "traefik.http.routers.traefik-secure.service" = "api@internal";
            "traefik.http.middlewares.traefik-auth.basicauth.users" = "admin:$2y$05$/UrxciXCv1x57qFZhDwBLOT2FkMjn2JoLW4yoXmKbQgbawFB8AJkq";
            "traefik.http.routers.traefik-secure.middlewares" = "traefik-auth";
          };
        };
      };
    };
  }
