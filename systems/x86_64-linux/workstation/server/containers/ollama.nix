{
  lib,
  config,
  ...
}: let 
  cfg = config.server.containers.ollama;
in with lib; {
  options.server.containers.ollama = {
    enable = mkEnableOption "Enable ollama llm execution";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      ollama = {
        image = "ollama/ollama:rocm";

        devices = [
          "/dev/kfd"
          "/dev/dri"
        ];

        volumes = [
          "/mnt/data/ollama/:/root/.ollama"
        ];

        networks = [
          "development_network"
        ];
      };
    };
  };
}