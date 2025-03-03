{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in {
  options.core.networking.tailscale = {
    enable =
      lib.mkEnableOption "Enable tailscale always on vpn"
      // {
        default = true;
      };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;

      authKeyFile = config.sops.secrets.tailscale_auth_key.path;
    };
  };
}
