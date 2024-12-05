{ pkgs, ... }: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "24.11";
}
