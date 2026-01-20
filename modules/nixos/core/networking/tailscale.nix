{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.networking.tailscale;
in
  with lib; {
    options.core.networking.tailscale = {
      enable = mkEnableOption "Enable tailscale always on vpn";

      auth = {
        enable = mkEnableOption "Enable tailscale authkey auto login";
      };

      service = {
        enable = mkEnableOption "Enable publishing of a service via tailscale reverse proxying";
        exposure = mkOption {
          type = with types; enum ["serve" "funnel"];
          default = "serve";
          description = "How much exposure to give the service, tailnet only or public internet accessable";
          example = "funnel";
        };
        config = mkOption {
          type = with types; nullOr str;
          default = null;
          description = "Tailscale serve configuration to load into tailscale";
          example = ''
            {
              "TCP": {
                "443": {
                  "HTTPS": true
                }
              },
              "Web": {
                "admin.xerus-augmented.ts.net:443": {
                  "Handlers": {
                    "/": {
                      "Proxy": "http://127.0.0.1:9000"
                    }
                  }
                }
              }
            }'';
        };
      };
    };

    config = lib.mkIf cfg.enable {
      sops.secrets."networking/tailscale/auth_key" = mkIf cfg.auth.enable {};

      networking.firewall.checkReversePath = "loose";

      services.tailscale = {
        enable = true;

        useRoutingFeatures = "both";

        openFirewall = true;

        extraDaemonFlags = [
          "--no-logs-no-support"
        ];

        extraSetFlags = [
          "--accept-dns"
          "--exit-node-allow-lan-access"
        ];
      };

      systemd.services = {
        tailscale-login = mkIf cfg.auth.enable {
          description = "Configure tailscale authorization";
          after = ["tailscale.service"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.writeShellApplication {
              name = "tailscale-login.sh";
              runtimeInputs = with pkgs; [
                tailscale
              ];
              text = ''
                if tailscale status >/dev/null 2>&1; then
                  echo "Tailscale is already logged in and active. Skipping login"
                else
                  echo "Not logged in. Authenticating with Tailscale..."

                  TS_AUTHKEY=$(sudo cat ${config.sops.secrets."networking/tailscale/auth_key".path})
                  TS_SUCCESS=$(sudo tailscale up --authkey="$TS_AUTHKEY")

                  if [ "$TS_SUCCESS" -eq 0 ]; then
                    echo "Successfully authenticated."
                  else
                    echo "Authentication failed."
                    exit 1
                  fi
                fi
              '';
            }}";
          };
        };
        tailscale-serve-init = mkIf (cfg.service.enable && cfg.service.exposure == "serve") {
          description = "Configure tailscale serve setup after tailscale has been logged-in";
          after = ["tailscale-login.service"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.writeShellApplication {
              name = "tailscale-serve-init.sh";
              runtimeInputs = with pkgs; [
                tailscale
              ];
              text = ''
                CURRENT_STATUS=$(tailscale serve status --json)
                if echo "$CURRENT_STATUS" | jq -e '.Service | length > 0' >/dev/null 2>&1 || \
                  echo "$CURRENT_STATUS" | jq -e '.Web | length > 0' >/dev/null 2>&1; then
                    echo "Tailscale Serve is already configured. Skipping to avoid overwriting."
                else
                  echo "No existing Serve config found. Applying new configuration..."

                  # Apply the config from the variable
                  echo "${cfg.service.config}" | tailscale serve set -

                  if [ $? -eq 0 ]; then
                      echo "Serve configuration applied successfully."
                  else
                      echo "Failed to apply Serve configuration."
                      exit 1
                  fi
                fi
              '';
            }}";
          };
        };
        tailscale-funnel-init = mkIf (cfg.service.enable && cfg.service.exposure == "funnel") {
          description = "Configure tailscale funnel setup after tailscale has been logged-in";
          after = ["tailscale-login.service"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.writeShellApplication {
              name = "tailscale-funnel-init.sh";
              runtimeInputs = with pkgs; [
                tailscale
              ];
              text = ''
                CURRENT_STATUS=$(tailscale funnel status --json)
                if echo "$CURRENT_STATUS" | jq -e '.Service | length > 0' >/dev/null 2>&1 || \
                  echo "$CURRENT_STATUS" | jq -e '.Web | length > 0' >/dev/null 2>&1; then
                    echo "Tailscale Funnel is already configured. Skipping to avoid overwriting."
                else
                  echo "No existing Funnel config found. Applying new configuration..."

                  # Apply the config from the variable
                  echo "${cfg.service.config}" | tailscale funnel set -

                  if [ $? -eq 0 ]; then
                      echo "Funnel configuration applied successfully."
                  else
                      echo "Failed to apply Funnel configuration."
                      exit 1
                  fi
                fi
              '';
            }}";
          };
        };
      };
    };
  }
