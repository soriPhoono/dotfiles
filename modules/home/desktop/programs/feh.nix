{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.feh;
in {
  options.desktop.programs.feh = lib.mkEnableOption "Enable feh image viewer";

  config = lib.mkIf cfg.enable {
    programs.feh.enable = true;
  };
}
