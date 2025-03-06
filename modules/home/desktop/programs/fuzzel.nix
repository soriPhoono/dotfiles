{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.fuzzel;
in {
  options.desktop.programs.fuzzel.enable = lib.mkEnableOption "Enable fuzzel application launcher";

  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true;
  };
}
