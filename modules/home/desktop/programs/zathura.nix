{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.zathura;
in {
  options.desktop.programs.zathura.enable = lib.mkEnableOption "Enable zathura pdf viewer";

  config = lib.mkIf cfg.enable {
    programs.zathura.enable = true;
  };
}
