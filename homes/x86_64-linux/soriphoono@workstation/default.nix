{
  imports = [
    ./nvim
  ];

  core = {
    secrets.defaultSopsFile = ./secrets.yaml;

    shells = {
      shellAliases = {
        v = "nvim";
      };
    };

    git = {
      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";
    };
  };

  userapps = {
    enable = true;
    development.enable = true;
  };
}
