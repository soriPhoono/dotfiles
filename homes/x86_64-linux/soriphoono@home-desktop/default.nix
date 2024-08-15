{ lib, host, ... }: {
  terminal = {
    programs = {
      system.enable = true;
      archiving.enable = true;
      development.enable = true;
    };
  };

  desktop = {
    programs = {
      enable = true;
      gaming.enable = true;
      streaming.enable = true;
    };
  };

  themes.catppuccin.enable = true;

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
