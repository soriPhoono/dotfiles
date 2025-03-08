{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.ghostty;
in {
  options.userapps.programs.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
    };
  };
}
