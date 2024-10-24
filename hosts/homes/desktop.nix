{
  imports = [
    ../common.nix
  ];

  home.sessionVariables.KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

  desktop.plasma.enable = true;

  userapps.development.advanced = true;
  userapps.streaming.enable = true;
}
