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
  };

  userapps.feature_sets = {
    global = true;
    gaming = true;
    streaming = true;
    artwork = true;
  };
}
