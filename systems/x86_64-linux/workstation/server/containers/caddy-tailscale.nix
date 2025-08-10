{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.caddy-tailscale;
in
  with lib; {
    options.server.containers.caddy-tailscale = rec {
      enable = mkEnableOption "Enable caddy with tailscale routing instance";

      tn_name = mkOption {
        type = with types; str;
        description = "Tailnet name";
        example = "woldorph.ts.net";
      };

      blocks = mkOption {
        type = with types; listOf str;
        default = [];
        description = "Routes to publish on caddy";
        example = [
          ''
            https://cloud.${tn_name}:80 {
              reverse_proxy localhost:8080
            }
          ''
        ];
      };
    };

    config = mkIf cfg.enable {
      sops.templates."caddy-tailscale.env".content = ''
        TS_AUTH_KEY=${config.sops.placeholder."core/ts_auth_key"}
      '';

      virtualisation.oci-containers.containers = with pkgs; {
        caddy-tailscale = {
          image = "caddy-tailscale:latest";
          imageFile = dockerTools.buildImage {
            name = "caddy-tailscale";
            tag = "latest";

            copyToRoot = buildEnv {
              name = "image-root";
              paths = [
                (buildGoModule rec {
                  pname = "caddy-tailscale";
                  version = "0.1.0";

                  src = fetchFromGitHub {
                    owner = "tailscale";
                    repo = "caddy-tailscale";
                    rev = "642f61f";
                    sha256 = "sha256-oVywoZH7+FcBPP1l+kKjh+deiI6+H/N//phAuiSC4tc=";
                  };

                  doCheck = false;

                  vendorHash = "sha256-eed3AuRhRO66xFg+447xLv7otAHbzAUuhxMcNugZMOA=";

                  meta = {
                    description = "Caddy tailscale AIO module";
                    homepage = "https://github.com/tailscale/caddy-tailscale";
                  };
                })
                nushell
              ];
              pathsToLink = [
                "/bin"
              ];
            };

            config = {
              Cmd = ["/bin/caddy" "run" "--adapter" "caddyfile" "--config" "/etc/caddy/config.caddy"];
            };

            diskSize = 1024;
            buildVMMemorySize = 512;
          };

          extraOptions = ["--net=host"];

          environmentFiles = [
            config.sops.templates."caddy-tailscale.env".path
          ];

          volumes = let
            caddyConfig = writeText "config.caddy" (builtins.concatStringsSep "\n\n" cfg.blocks);
          in
            [
              "${caddyConfig}:/etc/caddy/config.caddy:ro"
              "/mnt/data/caddy/:/.config/"
            ]
            ++ (
              if config.server.containers.nextcloud.enable
              then [
                "/mnt/cloud/:/var/www/html/"
              ]
              else []
            );
        };
      };
    };
  }
