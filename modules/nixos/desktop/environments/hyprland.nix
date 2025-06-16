{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.environments.hyprland;
in {
  options.desktop.environments.hyprland = with lib; {
    enable = mkEnableOption "Enable hyprland window manager";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };
  };
}
