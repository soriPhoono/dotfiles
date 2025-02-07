{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.btop;
in {
  options.core.programs.btop = {
    enable = lib.mkEnableOption "Enable btop system monitor";
  };

  config = lib.mkIf cfg.enable {
    programs.btop.enable = true;
  };
}
