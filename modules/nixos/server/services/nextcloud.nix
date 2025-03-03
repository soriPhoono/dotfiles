{
  lib,
  config,
  ...
}: let
  cfg = config.server.services.nextcloud;
in {
  options.server.services.nextcloud.enable = "Enable nextcloud natively on the system";

  config = lib.mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
    };
  };
}
