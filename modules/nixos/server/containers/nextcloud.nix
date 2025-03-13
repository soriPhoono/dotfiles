{
  lib,
  config,
  ...
}: let
  cfg = config.server.containers.nextcloud;
in {
  options.server.containers.nextcloud.enable = lib.mkEnableOption "Enable nextcloud container";

  config = lib.mkIf cfg.enable {
    containers.nextcloud = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.75.10";
      localAddress = "192.168.75.11";
      hostAddress6 = "fc00::1";
      localAddress6 = "fc00::2";
      config = {pkgs, ...}: {
        services.nextcloud = {
          enable = true;
          package = pkgs.nextcloud31;
          hostName = "localhost";
          config.adminpassFile = config.sops.secrets."nextcloud_admin".path;
        };

        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [80];
          };
        };

        system.stateVersion = "25.05";
      };
    };
  };
}
