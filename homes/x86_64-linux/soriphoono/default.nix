{ lib, host, ... }: {
  cli.enable = true;
  hyprland.enable = true;

  programs = {
    enable = true;

    development.enable = true;
    desktop.enable = true;
  };

  themes.catppuccin.enable = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
