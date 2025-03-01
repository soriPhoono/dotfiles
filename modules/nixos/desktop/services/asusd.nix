{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.asusd;
in {
  options.desktop.services.asusd.enable = lib.mkEnableOption "Enable asusd system controller";

  config = lib.mkIf cfg.enable {
    services.asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
