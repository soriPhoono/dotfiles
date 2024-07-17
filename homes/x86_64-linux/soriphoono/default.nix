{ host, ... }: {
  cli.enable = true;
  programs = {
    enable = true;

    development.enable = lib.mkIf host != "wsl";
    desktop.enable = lib.mkIf host != "wsl";
  };
  themes.catppuccin.enable = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
