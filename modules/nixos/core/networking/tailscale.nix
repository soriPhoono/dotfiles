{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  options.core.networking.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale always on vpn";

    useRoutingFeatures = lib.mkOption {
      type = lib.types.enum ["both" "client" "server"];
      description = "Enable routing features";
      default = "both";
    };

    tn_name = lib.mkOption {
      type = lib.types.str;
      description = "The name of your tailnet for hosting";
      example = "name.ts.net";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      inherit (cfg) useRoutingFeatures;

      enable = true;

      openFirewall = true;
    };
  };
}
