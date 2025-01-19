{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.bat;
in {
  options.core.programs.bat = {
    enable = lib.mkEnableOption "Install bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat.enable = true;
  };
}
