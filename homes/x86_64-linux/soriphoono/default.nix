{config, ...}: {
  core = {
    username = "soriphoono";

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

    programs.git = {
      username = "soriphoono";
      email = "soriphoono@gmail.com";
    };
  };

  nvim.soriphoono.enable = true;

  noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };

  sops.secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
}
