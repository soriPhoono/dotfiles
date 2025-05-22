{
  lib,
  config,
  ...
}: let
  cfg = config.server;
in {
  options.server = {
    enable = lib.mkEnableOption "Enable self hosted services";
  };

  config = lib.mkIf cfg.enable {
    services = {
      caddy = {
        enable = true;
      };
    };
  };
}
