{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.gvfs;
in {
  options.desktop.services.gvfs.enable = lib.mkEnableOption "Enable Gvfs";

  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
  };
}
