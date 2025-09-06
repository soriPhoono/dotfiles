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

  userapps.features = {
    enable = true;
    development.enable = true;
    streaming.enable = true;
    artwork.enable = true;
  };
}
