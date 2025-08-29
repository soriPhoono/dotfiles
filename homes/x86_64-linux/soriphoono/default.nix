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

  themes ={
    enable = true;
  };

  gnome.dconf.enable = true;
}
