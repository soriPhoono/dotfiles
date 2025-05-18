{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.virtualisation;
in {
  options.desktop.features.virtualisation = {
    enable = lib.mkEnableOption "Enable podman virtualization";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
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
