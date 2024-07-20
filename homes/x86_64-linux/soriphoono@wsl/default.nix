{ lib, host, ... }: {
  cli.enable = true;

  programs = {
    enable = true;

    home-manager.enable = true;
  };

  themes.catppuccin.enable = true;

  home.stateVersion = "24.11";
}
