{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules

    ../../modules/desktops/kde.nix
    
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/graphics.nix
    ../../modules/hardware/openrgb.nix
    ../../modules/hardware/logitech.nix
    ../../modules/hardware/qmk.nix
    ../../modules/hardware/xbox.nix

    ../../modules/programs/steam.nix

    ../../modules/services/pipewire.nix
  ];

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
