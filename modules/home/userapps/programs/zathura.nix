{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.zathura;
in {
  options.userapps.programs.zathura.enable = lib.mkEnableOption "Enable zathura pdf viewer";

  config = lib.mkIf cfg.enable {
    programs.zathura.enable = true;
  };
}
