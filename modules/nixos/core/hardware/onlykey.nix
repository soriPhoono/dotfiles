{
  lib,
  config,
  ...
}: let
  cfg = config.core.hardware.onlykey;
in {
  options.core.hardware.onlykey.enable = lib.mkEnableOption "Enable OnlyKey support";

  config = lib.mkIf cfg.enable {
    hardware.onlykey.enable = true;
  };
}
