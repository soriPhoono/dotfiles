{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.hyprlock;
in {
  options.desktop.programs.hyprlock = {
    enable = lib.mkEnableOption "Enable hyprlock installation";
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.hyprlock.text = "auth include login";
    programs.hyprlock.enable = true;
  };
}
