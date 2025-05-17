{
  inputs,
  pkgs,
  ...
}: {
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

    programs.zellij.enable = true;
  };

  sops.secrets.age_key.path = "$HOME/.config/sops/age/keys.txt";
}
