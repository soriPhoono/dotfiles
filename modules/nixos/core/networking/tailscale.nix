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
    networking.firewall.checkReversePath = "loose";

    services.tailscale = {
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
}
