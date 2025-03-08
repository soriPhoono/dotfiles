{
  imports = [
    ./nvim
  ];

  core = {
    secrets = {
      defaultSopsFile = ./secrets.yaml;

      environment = {
        enable = true;
        sopsFile = ./secrets.env;
      };
    };

    shells = {
      fish = {
        enable = true;

        shellVariables = {
          EDITOR = "nvim";
        };

        shellAliases = {
          v = "nvim";
        };
      };
      starship.enable = true;
    };

    programs = {
      git = {
        userName = "soriphoono";
        userEmail = "soriphoono@gmail.com";
      };
    };
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
