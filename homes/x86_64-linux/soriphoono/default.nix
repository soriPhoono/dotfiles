{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.username = "soriphoono";

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

  # nvim.enable = true;

  programs.nixvim.enable = true;

  sops.secrets.ssh_private.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
}
