{ inputs, ... }: {
  imports = [
    ../common.nix
  ];

  home.sessionVariables.KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

  userapps.development.advanced = true;
  userapps.streaming.enable = true;
}
