{ inputs, pkgs, vars, ... }: {
  imports = [

  ];

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}