{
  lib,
  config,
  ...
}: let
  namespace = "hosting.backends.podman";

  cfg = config.${namespace};
in
  with lib; {
    options.${namespace} = {
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
