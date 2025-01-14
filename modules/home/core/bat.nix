{
  lib,
  config,
  ...
}: let
  cfg = config.core.bat;
in {
  options.core.bat = {
    enable = lib.mkEnableOption "Install bat";
  };

  config = lib.mkIf cfg.enable {
    programs.bat.enable = true;
  };
}
