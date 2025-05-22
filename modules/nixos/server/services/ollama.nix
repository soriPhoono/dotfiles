{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.ollama;
in {
  options.server.services.ollama.enable = lib.mkEnableOption "Enable AI selfhosting";

  config = lib.mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        home = "/mnt/ollama/";
        host = "localhost";
        openFirewall = true;
        user = "ollama";
        acceleration = "rocm";
      };

      open-webui = {
        enable = true;
        openFirewall = true;
        host = "open-webui";
        port = 3000;
      };
    };
  };
}
