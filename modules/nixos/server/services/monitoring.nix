{
  lib,
  config,
  ...
}: let
  cfg = config.server.monitoring;

  dataDir = "/services/grafana/";

  domain = "monitoring.${config.core.networking.tailscale.tn_name}";
  endpoint = "https://${domain}";
in {
  services = {
    grafana = {
      inherit dataDir;

      enable = true;
      settings = {
        security = {
          disable_gravatar = true;
          strict_transport_security = true;
          cookie_secure = true;
        };
        server = {
          inherit domain;
          http_addr = "127.0.0.1";
          http_port = 2342;
          enforce_domain = true;
          enable_gzip = true;
        };
        database = {
          type = "mysql";
          user = "grafana";
          ssl_mode = "true";
        };
        analytics = {
          reporting_enabled = false;
          check_for_updates = false;
          check_for_plugin_updates = false;
        };
      };
    };

    prometheus = {
      enable = true;
      port = 9001;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = ["systemd"];
          port = 9002;
        };
      };
      scrapeConfigs = [
        {
          job_name = config.networking.hostName;
          static_configs = [
            {
              targets = ["127.0.0.1:${toString config.services.prometheus.exporters.node.port}"];
            }
          ];
        }
      ];
    };

    caddy.virtualHosts.${endpoint}.extraConfig = ''
      bind tailscale/monitoring
      reverse_proxy localhost:${builtins.toString config.services.grafana.port}
    '';
  };
}
