{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.server;
in {
  imports = [
    ./postgresql.nix

    ./nextcloud.nix
    ./jellyfin.nix

    ./ollama.nix
    ./gitlab.nix
  ];

  options.server = {
    enable = lib.mkEnableOption "Enable self hosted services";
  };

  config = lib.mkIf cfg.enable {
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
