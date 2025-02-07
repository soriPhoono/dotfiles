{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  config = lib.mkIf cfg.enable {
    networking.firewall = {
      trustedInterfaces = ["tailscale0"];
      checkReversePath = "loose";
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
