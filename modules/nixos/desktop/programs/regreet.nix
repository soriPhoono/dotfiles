{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.regreet;
in {
  options.desktop.programs.regreet.enable = lib.mkEnableOption "Enable regreet system";

  config = lib.mkIf cfg.enable {
    desktop.services.greetd.enable = true;

    programs.regreet.enable = true;
  };
}
