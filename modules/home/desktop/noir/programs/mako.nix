{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      borderRadius = 5;
      borderSize = 3;

      margin = "20";
    };
  };
}
