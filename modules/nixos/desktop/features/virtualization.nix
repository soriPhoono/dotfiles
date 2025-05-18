{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.virtualization;
in {
  options.desktop.features.virtualization = {
    enable = lib.mkEnableOption "Enable podman virtualization";
  };

  config = lib.mkIf cfg.enable {
    virtualization = {
      containers.enable = true;

      podman = {
        enable = true;

        dockerCompat = true;

        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers.backend = "podman";
    };

    environment.systemPackages = with pkgs; [
      dive
      podman-tui
      podman-compose
    ];
  };
}
