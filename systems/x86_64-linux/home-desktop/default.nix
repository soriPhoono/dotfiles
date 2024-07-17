{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [ "i915.force_probe=a780" ];

  boot.enable = true;
  bluetooth.enable = true;
  opengl.enable = true;
  logitech.enable = true;
  xbox.enable = true;

  core.cli.enable = true;
  networking.networkManager.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl

    intel-compute-runtime

    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };
}
