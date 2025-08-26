{
  imports = [
    ./dconf.nix

    ./nvim
    ./vscode.nix
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

  gnome.dconf.enable = true;
}
