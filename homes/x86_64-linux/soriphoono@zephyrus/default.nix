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

  themes.catppuccin.enable = true;

  home.stateVersion = "24.11";
}
