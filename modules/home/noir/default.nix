{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.noir;
in {
  options.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop configuration";
  };

  config = lib.mkIf cfg.enable {
    supporting.hyprland.enable = true;

    programs.kitty.enable = true;

    wayland.windowManager.hyprland.settings = {
      bind = [
        "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
      ];
    };
  };
}
