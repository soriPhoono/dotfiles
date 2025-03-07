{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.hypridle;
in {
  options.desktop.services.hypridle = {
    enable = lib.mkEnableOption "Enable hypridle";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;
  };
}
