{ ... }: {
  imports = [
    ../../modules/user/desktop/hyprland.nix
  ];

  # xdg.configFile."hypr/modules/monitors.conf".source =
  #   ../../config/hypr/modules/laptop.conf
}
