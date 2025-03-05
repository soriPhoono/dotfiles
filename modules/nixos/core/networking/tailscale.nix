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
    sops.secrets.tailscale_api_key = {
      restartUnits = [
        "tailscaled.service"
      ];
    };

    networking = {
      firewall.checkReversePath = "loose";
      interfaces.${config.services.tailscale.interfaceName}.useDHCP = false;
    };

    services.tailscale = {
      enable = true;

      openFirewall = true;

      useRoutingFeatures = "both";
    };

    systemd.services.tailscaled-autoconnect = {
      description = "Automatic connection to tailscale";

      after = ["network-pre.target" "tailscaled.service"];
      wants = ["network-pre.target" "tailscaled.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "oneshot";

      script = with pkgs;
      # bash
        ''
          sleep 2

          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then
            exit 0
          fi

          ${tailscale}/bin/tailscale up --auth-key "$(cat ${config.sops.secrets.tailscale_api_key.path})"
        '';
    };

    core.boot.impermanence.directories = [
      "/var/lib/tailscale"
    ];
  };
}
