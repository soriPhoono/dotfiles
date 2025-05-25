{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    inputs.nvim.packages.${system}.soriphoono
  ];

  sops.secrets.ssh_key.path = "${config.home.homeDirectory}/.ssh/id_ed25519";

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
}
