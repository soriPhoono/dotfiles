{
  lib,
  config,
  ...
}: let
  cfg = config.core.boot;
in {
  config = lib.mkIf cfg.enable {
    security.sudo.wheelNeedsPassword = false;
  };
}
