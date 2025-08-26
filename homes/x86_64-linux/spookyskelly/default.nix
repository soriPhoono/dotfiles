{
  imports = [
    ./dconf.nix
  ];

  core = {
    secrets.defaultSopsFile = ./secrets.yaml;

    git = {
      userName = "spookyskelly";
      userEmail = "karoshi1975@gmail.com";
    };
  };

  gnome.dconf.enable = true;
}