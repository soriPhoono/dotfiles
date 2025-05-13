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

    useRoutingFeatures = lib.mkOption {
      type = lib.types.enum ["both" "client" "server"];
      description = "Enable routing features";
      default = "both";
    };

    autoLogin = lib.mkEnableOption "Enable autologin to tailscale";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.tailscale_auth_key = lib.mkIf (config.core.secrets.enable && cfg.autoLogin) {
      restartUnits = [
        "tailscaled.service"
      ];
    };

    services.tailscale = {
      inherit (cfg) useRoutingFeatures;

      enable = true;

      openFirewall = true;
    };

    systemd.services = {
      tailscaled-autoconnect = lib.mkIf (config.core.secrets.enable && cfg.autoLogin) {
        description = "Automatic connection to tailscale";

        after = ["network-pre.target" "tailscaled.service"];
        wants = ["network-pre.target" "tailscaled.service"];
        wantedBy = ["multi-user.target"];

        serviceConfig.Type = "oneshot";

        script = with pkgs;
        # bash
          ''
            sleep 0.5

            status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
            if [ $status = "Running" ]; then
              exit 0
            fi

            ${tailscale}/bin/tailscale up --auth-key "$(cat ${config.sops.secrets.tailscale_auth_key.path})"
          '';
      };
    };
  };
}
