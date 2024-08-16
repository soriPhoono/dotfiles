{ lib, host, ... }: {
  terminal = {
    editors = {
      helix.enable = true;

      nvim.enable = true;
    };

    programs = {
      system.enable = true;
      archiving.enable = true;
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
