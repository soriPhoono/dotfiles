{
  lib,
  config,
  ...
}: let
  cfg = config.hosting.backends.podman;
in
  with lib; {
    options.hosting.backends.podman = {
      enable = mkEnableOption "Enable podman backend for service hosting related code";
    };

    config = mkIf cfg.enable {
      virtualisation.podman = {
        enable = true;
        dockerSocket.enable = true;
        dockerCompat = true;
        autoPrune = {
          enable = true;
          dates = "daily";
          flags = [
            "--all"
          ];
        };
      };
    };
  }
