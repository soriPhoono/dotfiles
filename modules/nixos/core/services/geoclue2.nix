{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.geoclue2;
in {
  options.core.services.geoclue2.enable = lib.mkEnableOption "Enable location based services support";

  config = lib.mkIf cfg.enable {
    # enable location service
    location.provider = "geoclue2";

    # provide location
    services.geoclue2 = {
      enable = true;
      geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
      submissionUrl = "https://api.beacondb.net/v2/geosubmit";
      submissionNick = "geoclue";

      appConfig.gammastep = {
        isAllowed = true;
        isSystem = false;
      };
    };
  };
}
