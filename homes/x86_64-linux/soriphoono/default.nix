{
  core = {
    secrets = {
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

    programs.git = {
      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";
    };
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };

  sops.secrets.ssh_private.path = "~/.ssh/id_ed25519";
}
