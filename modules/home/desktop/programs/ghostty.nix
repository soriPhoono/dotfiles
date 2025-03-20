{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.ghostty;
in {
  options.desktop.programs.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
    };
  };
}
