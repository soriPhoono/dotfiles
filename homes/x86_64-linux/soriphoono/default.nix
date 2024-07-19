{ lib, host, ... }: {
  cli.enable = true;
  hyprland.enable = true;

  programs = {
    enable = true;

    development.enable = true;
    desktop.enable = true;

    home-manager.enable = true;
  };

  themes.catppuccin.enable = true;
  
  home.stateVersion = "24.11";
}
