{
  inputs,
  pkgs,
  config,
  ...
}: {
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
      fish = {
        enable = true;
        workspace = inputs.nvim.packages.${pkgs.system}.hollace;
      };

      starship.enable = true;
    };

    editors.neovim = {
      enable = true;
    };

    programs.git = {
      username = "soriphoono";
      email = "soriphoono@gmail.com";
    };
  };

  noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };

  sops.secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
}
