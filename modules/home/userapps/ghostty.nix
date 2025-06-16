{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.userapps.ghostty;
in {
  options.userapps.ghostty = {
    enable = mkEnableOption "Enable ghostty terminal";
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      settings = {
        font-size = 16;
      };
    };
  };
}
