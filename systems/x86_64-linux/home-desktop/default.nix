{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.enable = true;
  boot.kernelParams = [ "i915.force_probe=a780" ];

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;

    logitech.enable = true;
    xbox.enable = true;
  };

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };
}
