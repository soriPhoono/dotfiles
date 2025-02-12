{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.ssd;
in {
  options.core.hardware.ssd.enable = lib.mkEnableOption "Enable ssd health services and associated systems";

  config = lib.mkIf (config.core.hardware.enable && cfg.enable) {
    services.fstrim.enable = true;
  };
}
