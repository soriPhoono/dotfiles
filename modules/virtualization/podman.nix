{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.podman;
in {
  options = {
    desktop.programs.podman.enable =
      lib.mkEnableOption "Enable docker container manager";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;

      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [ dive podman-tui podman-compose ];
  };
}
