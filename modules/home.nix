{ username, ... }: {
  imports = [
    ./user
  ];

  programs = {
    home-manager.enable = true;
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };
}
