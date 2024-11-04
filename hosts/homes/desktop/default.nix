{
  imports = [
    ../common.nix
  ];

  home.sessionVariables.KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

  userapps.streaming.enable = true;
}
