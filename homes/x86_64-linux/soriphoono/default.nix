{ lib, host, ... }: {
  cli.enable = true;
  hyprland.enable = host != "wsl";

  programs = {
    enable = true;

    development.enable = host != "wsl";
    desktop.enable = host != "wsl";
  };

  themes.catppuccin.enable = host != "wsl";

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
