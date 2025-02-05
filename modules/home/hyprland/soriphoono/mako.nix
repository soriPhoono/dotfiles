{
  lib,
  config,
  ...
}: let
  cfg = config.supporting.mako;
in {
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      borderRadius = 5;
      borderSize = 3;

      padding = 20;
    };
  };
}
