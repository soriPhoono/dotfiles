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
    ./services/mailserver.nix

    ./containers/caddy.nix

    ./cloud.nix
    ./multimedia.nix
    ./chat.nix
  ];

  options.server = with lib; {
    enable = mkEnableOption "Enable self hosted services";
  };

  config = lib.mkIf cfg.enable {
    # sops.templates.caddy_env_file = {
    #   content = ''
    #     TS_AUTH_KEY=${config.sops.placeholder."core/ts_auth_key"}
    #     TS_PERMIT_CERT_UID=${config.services.caddy.user};
    #   '';
    #   owner = config.services.caddy.user;
    # };

    # core.networking.tailscale.enable = true;

    # services = {
    #   caddy = {
    #     enable = true;
    #     enableReload = false;
    #     package = pkgs.caddy.withPlugins {
    #       plugins = ["github.com/tailscale/caddy-tailscale@v0.0.0-20250508175905-642f61fea3cc"];
    #       hash = "sha256-0GsjeeJnfLsJywWzWwJcCDk5wjTSBwzqMBY7iHjPQa8=";
    #     };
    #   };
    # };

    # systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.templates.caddy_env_file.path;

    environment.systemPackages = with pkgs; [
      podman-compose
    ];

    virtualisation = {
      podman = {
        enable = true;
        autoPrune.enable = true;
      };
      oci-containers.backend = "podman";
    };

    server.containers.caddy.enable = true;
  };
}
