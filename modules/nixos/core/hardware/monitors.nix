{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.monitors;
in {
  options.core.hardware.monitors.enable = lib.mkEnableOption "Enable support for monitor brightness controls";

  config = lib.mkIf cfg.enable {
    hardware.brillo.enable = true;
  };
}
