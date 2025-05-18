{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  options.server.services.nextcloud = {
    enable = lib.mkEnableOption "Enable nextcloud backend services";
  };

  config =
    lib.mkIf cfg.enable {
    };
}
