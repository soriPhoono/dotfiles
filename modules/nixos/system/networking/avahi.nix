{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  config = lib.mkIf cfg.enable {
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          domain = true;
          userServices = true;
        };
      };
    };
  };
}
