{
  inputs,
  config,
  ...
}: {
  home.username = "soriphoono";

  nvim.enable = true;

  core = {
    secrets.enable = true;

    shells = {
      fish.enable = true;
      starship.enable = true;
    };

    programs.git = {
      username = "soriphoono";
      email = "soriphoono@gmail.com";
    };
  };

  sops.secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
}
