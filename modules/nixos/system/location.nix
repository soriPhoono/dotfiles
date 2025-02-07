{
  lib,
  config,
  ...
}: let
  cfg = config.system.services.location;
in {
  options.system.services.location.enable = lib.mkEnableOption "Enable location based services support";

  config = lib.mkIf cfg.enable {
    # enable location service
    location.provider = "geoclue2";

    # provide location
    services.geoclue2 = {
      enable = true;
      geoProviderUrl = "https://beacondb.net/v1/geolocate";
      submissionUrl = "https://beacondb.net/v2/geosubmit";
      submissionNick = "geoclue";

      appConfig.gammastep = {
        isAllowed = true;
        isSystem = false;
      };
    };
  };
}
