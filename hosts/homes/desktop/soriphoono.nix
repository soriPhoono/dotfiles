{
  imports = [
    ../common.nix
  ];

  core.programs = {
    git = {
      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";
    };
  };

  desktop = {
    gtk.enable = true;
    qt.enable = true;

    kde.enable = true;
  };

  userapps.feature_sets = {
    global = true;
    streaming = true;
  };
}
