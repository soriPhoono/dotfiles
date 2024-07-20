{ lib, host, ... }: {
  cli.enable = true;
  hyprland.enable = true;

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,1920x1080@144,0x0,1"
  ];

  programs = {
    enable = true;

    development.enable = true;
    desktop.enable = true;

    home-manager.enable = true;
  };

  themes.catppuccin.enable = true;
  
  home.stateVersion = "24.11";
}
