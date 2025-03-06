{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.kitty;
in {
  options.desktop.programs.kitty.enable = lib.mkEnableOption "Enable kitty terminal";

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_shape = "beam";
        cursor_trail = 1;
      };
    };
  };
}
