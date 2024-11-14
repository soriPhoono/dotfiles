{
  imports = [
    ../common.nix
  ];

  desktop = {
    gtk.enable = true;
    qt.enable = true;

    kde.enable = true;
  };

  userapps.feature_sets = {
    global = true;
    development = true;
    gaming = true;
  };
}
