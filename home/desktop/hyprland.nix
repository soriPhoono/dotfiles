{ ... }: {
  wayland.windowManager.hyprland.enable = true;

  # TODO: Change this to declarative configuration after debugging
  xdg.configFile."hypr/hyprland.conf".source =
    ../../../config/hypr/hyprland.conf;
  xdg.configFile."hypr/modules/environment.conf".source =
    ../../../config/hypr/modules/environment.conf;
  xdg.configFile."hypr/modules/dispatchers.conf".source =
    ../../../config/hypr/modules/dispatchers.conf;
  xdg.configFile."hypr/modules/rules.conf".source =
    ../../../config/hypr/modules/rules.conf;
  xdg.configFile."hypr/modules/autostart.conf".source =
    ../../../config/hypr/modules/autostart.conf;
}
