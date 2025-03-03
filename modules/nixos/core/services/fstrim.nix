{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.fstrim;
in {
  options.core.services.fstrim.enable = lib.mkEnableOption "Enable fstrim service";

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
