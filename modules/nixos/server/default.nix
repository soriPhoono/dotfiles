{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./services/backups.nix
    ./services/mysql.nix
    ./services/redis.nix
    ./services/ldap.nix
    ./services/mailserver.nix

    ./cloud.nix
    ./multimedia.nix

    ./chat.nix
    ./development.nix
  ];

  options.server = with lib; {
    enable = mkEnableOption "Enable self hosted services";

    groups = mkOption {
      type = with types; listOf str;
      description = "The groups available on the server for sorting user permissions";
      default = [];
      example = [
        "jellyfin_users"
      ];
    };

    users = mkOption {
      type = with types;
        attrsOf (submodule {
          options = {
            first_name = mkOption {
              type = str;
              default = "";
              description = "The first name of the user";
              example = "John";
            };
            last_name = mkOption {
              type = str;
              default = "";
              description = "The last name of the user";
              example = "Jones";
            };
            password_hash = mkOption {
              type = str;
              description = "The password hash of the server user for each integrated service account";
              example = "+7k+lFi72O+ip4BzjWc/Z/f5J+YVyF06";
            };
            email = mkOption {
              type = str;
              description = "The email of the user";
              example = "johnjones@gmail.com";
            };
            groups = mkOption {
              type = listOf str;
              default = [];
              description = "The groups the user is apart of";
              example = [
                "jellyfin_users"
              ];
            };
          };
        });
      description = "The users of the server expressed as an attrset";
      default = {};
      example = {
        john_jones = {
          first_name = "John";
          last_name = "Jones";
        };
      };
    };

    home-page = {
      services = mkOption {
        type = with types;
          attrsOf (submodule {
            options = {
              description = mkOption {
                type = types.str;
                description = "The description of the service link";
                example = "This is a service";
              };
              href = mkOption {
                type = types.str;
                description = "The hyperlink of the service on the tailnet";
              };
            };
          });
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.homepage-dashboard.services = [
    ];

    sops.templates.caddy_env_file = {
      content = ''
        TS_AUTH_KEY=${config.sops.placeholder."core/ts_auth_key"}
        TS_PERMIT_CERT_UID=${config.services.caddy.user};
      '';
      owner = config.services.caddy.user;
    };

    core.networking.tailscale.enable = true;

    services = {
      caddy = {
        enable = true;
        enableReload = false;
        package = pkgs.caddy.withPlugins {
          plugins = ["github.com/tailscale/caddy-tailscale@v0.0.0-20250508175905-642f61fea3cc"];
          hash = "sha256-Kbqr7spiL8/UvT0HtCm0Ufh5Nm1VYDjyNWPCd1Yxyxc=";
        };
      };
    };

    systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.templates.caddy_env_file.path;
  };
}
