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
        image = "mariadb:latest";

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
          "443:443"
        ];

        environmentFiles = [
          config.sops.templates.caddy-environment.path
        ];
      };
    };
  };
}
