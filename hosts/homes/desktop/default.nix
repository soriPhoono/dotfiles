{
  imports = [
    ../common.nix
  ];

  desktop = {
    gtk.enable = true;
    qt.enable = true;
  };

  userapps = {
    enable = true;
    streaming = true;
  };
}
