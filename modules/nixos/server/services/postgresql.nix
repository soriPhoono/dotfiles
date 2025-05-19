{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.postgresql;
in {
  options.server.services.postgresql = {
    enable = lib.mkEnableOption "Enable postgresql database";
  };

  config =
    lib.mkIf cfg.enable {
    };
}
