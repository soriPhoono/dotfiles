{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.homepage-dashboard;
in
  with lib; {
    options.server.containers.homepage-dashboard = {
      enable = mkEnableOption "Enable homepage-dashboard for server";
    };

    config = mkIf cfg.enable {
      virtualisation.oci-containers.containers = {
        homepage-dashboard = {
          image = "ghcr.io/gethomepage/homepage:latest";

          environment = {
            HOMEPAGE_ALLOWED_HOSTS = "home.xerus-augmented.ts.net";
          };

          volumes = [
            "/mnt/config/homepage-dashboard:/app/config"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];

          ports = [
            "8060:3000"
          ];
        };
      };
    };
  }
