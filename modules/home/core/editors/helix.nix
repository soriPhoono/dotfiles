{
  lib,
  config,
  ...
}: let
  cfg = config.core.editors.helix;
in {
  options.core.editors.helix = {
    enable = lib.mkEnableOption "Enable helix text editor";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
    };
  };
}
