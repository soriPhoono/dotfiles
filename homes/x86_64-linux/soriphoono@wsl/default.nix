{
  lib,
  pkgs,
  config,
  ...
}: {
  core = {
    secrets = {
      defaultSopsFile = ../soriphoono/secrets.yaml;
      environment = {
        enable = true;
        sopsFile = ../soriphoono/secrets.env;
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

  sops = {
    age.keyFile = lib.mkForce "~/.config/sops/age/keys.txt";

    secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  };

  programs.bash.initExtra = ''
    ${pkgs.fish}/bin/fish
  '';
}
