{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.soriphoono;
in {
  config = lib.mkIf cfg.enable {
    programs.wofi.enable = true;
  };
}
