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
    sops.secrets."core/ts_auth_key" = {
      restartUnits = ["tailscaled_autoconnect.service"];
    };

    networking.firewall.checkReversePath = "loose";

    services = {
      tailscale = {
        enable = true;

        useRoutingFeatures = "both";

        openFirewall = true;
      };
    };

    systemd.services = {
      "tailscaled_autoconnect" = {
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

            ${tailscale}/bin/tailscale up --auth-key "$(cat ${config.sops.secrets."core/ts_auth_key".path})" --exit-node-allow-lan-access
          '';
      };
    };
  };
}
