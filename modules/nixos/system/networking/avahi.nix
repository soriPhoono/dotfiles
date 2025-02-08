{
  lib,
  config,
  ...
}: let
  cfg = config.system.networking;
in {
  config = lib.mkIf cfg.enable {
    # TODO: check to see if avahi should be enabled on clients or only servers?
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
