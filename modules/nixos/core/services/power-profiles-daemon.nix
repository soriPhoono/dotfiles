{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.power-profiles-daemon;
in {
  options.core.services.power-profiles-daemon.enable = lib.mkEnableOption "Enable power profiles daemon service";

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon.enable = true;
  };
}
