{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.hosting;
in {
  options.desktop.features.hosting.enable = lib.mkEnableOption "Enable services hosting for target machine";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      podman-compose
    ];

    virtualisation.podman = {
      enable = true;
    };
  };
}
