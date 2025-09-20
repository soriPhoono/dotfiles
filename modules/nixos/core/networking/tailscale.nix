{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  options.core.networking.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale always on vpn";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."core/ts_auth_key" = {};

    networking.firewall.checkReversePath = "loose";

    services = {
      tailscale = {
        enable = true;

        useRoutingFeatures = "both";

        openFirewall = true;

        extraDaemonFlags = [
          "--no-logs-no-support"
        ];

        extraSetFlags = [
          "--accept-dns"
          "--exit-node-allow-lan-access"
        ];
      };
    };
  };
}
