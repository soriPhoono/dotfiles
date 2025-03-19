{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.mpv;
in {
  options.desktop.programs.mpv.enable = lib.mkEnableOption "Enable mpv";

  config = lib.mkIf cfg.enable {
    programs.mpv.enable = true;
  };
}
