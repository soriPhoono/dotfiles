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
    lockToTailnet = lib.mkEnableOption "Enable tailnet only dns resolution and connection";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."core/ts_auth_key" = {};

    networking.firewall.checkReversePath = "loose";

    services = {
      resolved = lib.mkIf cfg.lockToTailnet {
        dnsovertls = "true";
        dnssec = "true";
        fallbackDns = [];
        extraConfig = ''
          [Resolve]
          DNSStubListener=no
        '';
      };

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
