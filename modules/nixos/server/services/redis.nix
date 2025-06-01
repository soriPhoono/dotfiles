{
  config,
  lib,
  ...
}: let
  cfg = config.server.redis;
in {
  options.server.redis = {
    enable = lib.mkEnableOption "Enable redis in memory database";
    databases = lib.mkOption {
      type = lib.types.int;
      default = 16;
    };
  };

  config = lib.mkIf cfg.enable {
    services.redis = {
      vmOverCommit = true;
      servers."" = {
        enable = true;
        inherit (cfg) databases;
        port = 0;
      };
    };
  };
}
