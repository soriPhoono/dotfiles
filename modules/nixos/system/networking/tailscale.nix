{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  config = lib.mkIf cfg.enable {
    networking = {
      nameservers = ["100.100.100.100"];
      search = []; # TODO: finish tailscale networking system

      firewall = {
        trustedInterfaces = ["tailscale0"];
        checkReversePath = "loose";
      };
    };

    systemd.network.wait-online.enable = false;

    services.tailscale = {
      enable = true;
      openFirewall = true;
    };

    environment.persistence."/persist".directories = [
      "/var/lib/tailscale"
    ];
  };
}
