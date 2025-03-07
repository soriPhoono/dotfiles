{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.mako;
in {
  options.desktop.services.mako.enable = lib.mkEnableOption "Enable mako notification daemon";

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      borderRadius = 5;
      borderSize = 3;

      margin = "20";
      defaultTimeout = 2500;
    };
  };
}
