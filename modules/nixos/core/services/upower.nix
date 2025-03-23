{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.upower;
in {
  options.core.services.upower.enable = lib.mkEnableOption "Enable upower battery systems";

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
  };
}
