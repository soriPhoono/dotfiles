{ lib, host, ... }: {
  terminal.programs.development.enable = true;

  desktop = {
    hyprland.enable = true;

    programs = {
      enable = true;
      development.enable = true;
      gaming.enable = true;
      streaming.enable = true;
    };
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,1920x1080@144,0x0,1"
  ];

  themes.catppuccin.enable = true;

  home.stateVersion = "24.11";
}
