{
  imports = [
    ../common.nix
  ];

  desktop.gtk.enable = true;

  userapps = {
    enable = true;
    streaming = true;
  };
}
