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

    tn_name = lib.mkOption {
      type = lib.types.str;
      description = "The name of your tailnet for hosting";
      example = "name.ts.net";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.ts_auth_key = {};

    services = {
      tailscale = {
        inherit (cfg) useRoutingFeatures;

        enable = true;

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

            ${tailscale}/bin/tailscale up --auth-key "$(cat ${config.sops.secrets.ts_auth_key.path})"
          '';
      };
    };
  };
}
