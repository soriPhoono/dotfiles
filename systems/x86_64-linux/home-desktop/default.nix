{ inputs, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [ "i915.force_probe=a780" ];

  core = {
    boot.enable = true;

    hardware = {
      bluetooth.enable = true;
      logitech.enable = true;
      graphics.enable = true;
      qmk_keyboard.enable = true;
      xbox_controller.enable = true;
    };

    networking.networkManager.enable = true;
  };

  desktop = {
    managers.kde.enable = true;

    programs = {
      enable = true;
      gaming.enable = true;
    };

    services.openrgb.enable = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vaapiVdpau
    libvdpau-va-gl

    intel-compute-runtime

    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };
}
