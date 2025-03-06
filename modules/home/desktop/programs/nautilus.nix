{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.programs.nautilus;
in {
  options.desktop.programs.nautilus.enable = lib.mkEnableOption "Enable nautilus file manager";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nautilus
      file-roller
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, E, exec, ${pkgs.nautilus}/bin/nautilus"
    ];
  };
}
