{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.enable = true;
  boot.kernelParams = [ "i915.force_probe=a780" ];

  cli.enable = true;

  bluetooth.enable = true;
  opengl.enable = true;
  logitech.enable = true;
  xbox.enable = true;
  qmk.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl

    intel-compute-runtime

    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  networking.networkManager.enable = true;

  hyprland.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  programs.steam.enable = true;
  services.openrgb.enable = true;
}
