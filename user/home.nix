{ vars, ... }:
let
  user = "${vars.user}";
in {
  imports = [
    ./modules
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
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "23.11";
  };
}
