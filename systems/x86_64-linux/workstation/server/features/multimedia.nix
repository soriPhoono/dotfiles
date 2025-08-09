{
  lib,
  config,
  ...
}: let 
  cfg = config.server.features.multimedia;
in with lib; {
  options.server.features.multimedia = {
    enable = mkEnableOption "Enable multimedia server";
  };

  config = mkIf cfg.enable {
    server.containers = {
      jellyfin.enable = true;
    };
  };
}