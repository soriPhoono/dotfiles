{
  programs.git = {
    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";
  };

  core = {
    secrets = {
      enable = true;

      defaultSopsFile = ./secrets.yaml;

      environment = {
        enable = true;
        sopsFile = ./secrets.env;
      };
    };

    shells = {
      fish.enable = true;
      starship.enable = true;
    };
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
