{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./jellyfin.nix
  ];

  options.server = {
    enable = lib.mkEnableOption "Enable self hosted services";
  };

  config = lib.mkIf cfg.enable {
    sops.templates.caddy_env_file = {
      content = ''
        TS_AUTHKEY=${config.sops.placeholder.ts_auth_key}
        TS_PERMIT_CERT_UID=${config.services.caddy.user};
      '';
      owner = config.services.caddy.user;
    };

    core.networking.tailscale.enable = true;

    services = {
      caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = ["github.com/tailscale/caddy-tailscale@v0.0.0-20250207163903-69a970c84556"];
          hash = "sha256-wt3+xCsT83RpPySbL7dKVwgqjKw06qzrP2Em+SxEPto=";
        };
      };
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.templates.caddy_env_file.path;
  };
}
