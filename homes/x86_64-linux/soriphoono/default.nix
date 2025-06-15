{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./dconf.nix

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
}
