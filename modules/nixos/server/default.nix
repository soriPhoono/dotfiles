{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  options.server = {
    enable = lib.mkEnableOption "Enable self hosted services";
  };

  config = lib.mkIf cfg.enable {
    core.networking.tailscale.enable = true;

    services.caddy = {
      enable = true;
      package = pkgs.callPackage ./caddy-tailscale.nix {};
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = "TS_AUTHKEY=${config.sops.secrets.ts_auth_key.path}";

    server.services = {
      nextcloud.enable = true;
      jellyfin.enable = true;
    };
  };
}
