{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  options.core.networking.tailscale = {
    enable = lib.mkEnableOption "Enable Tailscale";

    useRoutingFeatures = lib.mkOption {
      type = lib.types.str;
      default = "both";
      description = "Enable Tailscale's routing features.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscaled = {
      enable = true;

      inherit (cfg) useRoutingFeatures;

      openFirewall = true;

      authKeyFile = "${config.sops.secrets.tailscale_key.path}";
    };
  };
}
