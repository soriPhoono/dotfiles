{
  lib,
  pkgs,
  config,
  ...
}: let 
  cfg = config.server.containers.caddy-tailscale;
in with lib; {
  options.server.containers.caddy-tailscale = {
    enable = mkEnableOption "Enable caddy with tailscale routing instance";

    routes = mkOption {
      type = with types; attrsOf str;
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
            Cmd = [ "/bin/caddy" "run" "--adapter" "caddyfile" "--config" "/etc/caddy/config.caddy" ];
          };

          diskSize = 1024;
          buildVMMemorySize = 512;
        };

        environmentFiles = [
          config.sops.templates."caddy-tailscale.env".path
        ];

        volumes = let 
          caddyConfig = pkgs.writeText "Caddyfile" ''
            cloud.xerus-augmented.ts.net {
              bind tailscale/cloud
              reverse_proxy localhost:8080
            }
          '';
        in [
          "${caddyConfig}:/etc/caddy/config.caddy"
          "/mnt/data/caddy/:/.config/tsnet-caddy-cloud/"
        ];

        networks = [
          "server_net"
        ];
      };
    };
  };
}