{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server.containers.caddy;
in {
  options = {
    server.containers.caddy = {
      enable = lib.mkEnableOption "Caddy web server container";

      servers = lib.mkOption {
        type = with lib.types; attrsOf str;
        default = {};
        description = "A set of server configurations for Caddy.";
        example = {
          "example.com" = ''
            reverse_proxy localhost:8080
          '';
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    sops.templates.caddy-environment.content = ''
      TS_AUTHKEY=${config.sops.placeholder."core/ts_auth_key"}
    '';

    virtualisation = {
      oci-containers.containers.caddy = {
        image = "caddy-tailscale:latest";
        imageFile = pkgs.dockerTools.buildImage {
          name = "caddy-tailscale";
          tag = "latest";

          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = [
              (pkgs.buildGoModule {
                pname = "caddy-tailscale";
                version = "2.10";

                src = pkgs.fetchFromGitHub {
                  owner = "tailscale";
                  repo = "caddy-tailscale";
                  rev = "642f61fea3ccc6b04caf381e2f3bc945aa6af9cc";
                  hash = "sha256-oVywoZH7+FcBPP1l+kKjh+deiI6+H/N//phAuiSC4tc=";
                };

                vendorHash = "sha256-eed3AuRhRO66xFg+447xLv7otAHbzAUuhxMcNugZMOA=";

                nativeBuildInputs = with pkgs; [
                  git
                  go
                ];

                preBuild = ''
                  export HOME=$(mktemp -d)
                '';

                buildPhase = ''
                  runHook preBuild

                  go build ./cmd/caddy

                  runHook postBuild
                '';

                installPhase = ''
                  runHook preInstall

                  mkdir -p $out/bin
                  cp caddy $out/bin/caddy

                  runHook postInstall
                '';
              })
            ];
            pathsToLink = [
              "/bin"
            ];
          };

          config.Cmd = ["/bin/caddy" "run" "--config" "/etc/caddy/Caddyfile"];

          diskSize = 1024;
          buildVMMemorySize = 512;
        };

        volumes = let
          caddyFile = pkgs.writeText "Caddyfile" (builtins.concatStringsSep
            "\n"
            (lib.mapAttrsToList (name: config: ''
                ${name} {
                  ${config}
                }
              '')
              cfg.servers));
        in [
          "${caddyFile}:/etc/caddy/Caddyfile"
        ];

        ports = [
          "80:80"
        ];

        environmentFiles = [
          config.sops.templates.caddy-environment.path
        ];
      };
    };
  };
}
