{
  lib,
  config,
  ...
}: let cfg = config.desktop.environments.sway;
in with lib; {
  options.desktop.environments.sway = {
    enable = mkEnableOption "Enable the Sway desktop environment.";
  };

  config = mkIf cfg.enable {
    programs.sway.enable = true;
  };
}
