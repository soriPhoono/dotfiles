{
  lib,
  config,
  ...
}: let
  cfg = config.system.services.asusd;
in {
  options.system.services.asusd = {
    enable = lib.mkEnableOption "Enable asusd system controller";
  };

  config = lib.mkIf cfg.enable {
    services.asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
