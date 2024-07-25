{ lib, host, ... }: {
  terminal.programs.development.enable = true;

  desktop = {
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
