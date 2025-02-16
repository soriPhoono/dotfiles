{config, ...}: {
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
      fish.enable = true;
      nushell.enable = true;
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

  sops.secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
}
