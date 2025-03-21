{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.obs-studio;
in {
  options.userapps.programs.obs-studio.enable = lib.mkEnableOption "Enable open broadcaster studio";

  config = lib.mkIf cfg.enable {
    programs.obs-studio.enable = true;
  };
}
