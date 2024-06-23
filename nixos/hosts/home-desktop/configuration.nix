{ pkgs, stateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/hardware

    ../../modules/nixos/programs/gnupg.nix
    ../../modules/nixos/programs/gaming.nix

    ../../modules/nixos/services/auto-cpufreq.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  hardware = {
    opengl = {
      enable = true;

      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl

        intel-compute-runtime

        rocmPackages.clr.icd
      ];
    };

    intel-gpu-tools.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.sessionVariables = {
    KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";

    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  system.stateVersion = "${stateVersion}";
}
