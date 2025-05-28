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
