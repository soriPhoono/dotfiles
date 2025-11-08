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
      projectsDir = "/run/media/soriphoono/Projects";
      extraIdentities = {
        work_key = {
          directory = "Work";
          name = "xrezdev11";
          email = "xrezdev11@gmail.com";
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAxax8ouXfptDoQkw4C0FgA4USyS8U6UZu76RRE2VtI";
        };
      };
    };
  };

  userapps = {
    enable = true;
    development.enable = true;
  };
}
