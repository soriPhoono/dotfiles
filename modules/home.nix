{ username, ... }: {
  imports = [
    ./user
  ];

  programs = {
    home-manager.enable = true;
  };

  xdg = {
    enable = true;

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "imv.desktop";
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    systemDirs.enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };
}
