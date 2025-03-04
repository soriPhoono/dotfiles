{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  options.core.networking.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale always on vpn";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.tailscale_api_key = {
      restartUnits = [
        "tailscaled.service"
      ];
    };

    services.tailscale = {
      enable = true;

      authKeyFile = config.sops.secrets.tailscale_api_key.path;
      authKeyParameters.preauthorized = true;
    };
  };
}
