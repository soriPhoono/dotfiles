{ config, pkgs, ... }: {
  enable = true;

  anchor = "top-right";
  margin = "20,20,5";

  borderRadius =
    config.wayland.windowManager.hyprland.settings.decoration.rounding;
  borderSize =
    config.wayland.windowManager.hyprland.settings.general.border_size;

  defaultTimeout = 3000;

  maxVisible = 3;

  height = 180;
  width = 320;

  iconPath = "${pkgs.papirus-icon-theme}/usr/share/icons";
}
