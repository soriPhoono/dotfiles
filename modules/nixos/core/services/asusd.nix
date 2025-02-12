{
  lib,
  config,
  ...
}: let
  cfg = config.core.services.asusd;
in {
  options.core.services.asusd.enable = lib.mkEnableOption "Enable asusd system controller";

  config = lib.mkIf cfg.enable {
    services.asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
