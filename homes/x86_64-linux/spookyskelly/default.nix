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

  themes = {
    enable = true;

    background = ../../../assets/wallpapers/tech_ripples.png;
  };

  gnome.dconf.enable = true;
}
