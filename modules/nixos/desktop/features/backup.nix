{
  lib,
  config,
  ...
}: let cfg = config.desktop.features.backup;
in with lib; {
  options.desktop.features.backup = {
    enable = mkEnableOption "Enable syncthing backup to nextcloud server";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      relay = {
        enable = true;
      };
      settings = {
        options.urAccepted = -1;
      };
    };
  };
}
