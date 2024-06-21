{ pkgs, stateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/core/file-system.nix
    ../../modules/nixos/core/localization.nix
    ../../modules/nixos/core/network-manager.nix

    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/i2c.nix
    ../../modules/nixos/hardware/logitech.nix
    ../../modules/nixos/hardware/qmk.nix
    ../../modules/nixos/hardware/xbox.nix

    ../../modules/nixos/programs
    ../../modules/nixos/programs/gaming.nix

    ../../modules/nixos/services/auto-cpufreq.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  hardware.opengl = {
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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };

  system.stateVersion = "${stateVersion}";
}
