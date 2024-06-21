{ pkgs, stateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/core/file-system.nix
    ../../modules/nixos/core/localization.nix
    ../../modules/nixos/core/network-manager.nix

    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/opengl.nix
    ../../modules/nixos/hardware/xbox.nix

    ../../modules/nixos/programs
    ../../modules/nixos/programs/gaming.nix

    ../../modules/nixos/services/auto-cpufreq.nix
    ../../modules/nixos/services/fprintd.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  hardware = {
    nvidia.open = true;

    opengl = {
      enable = true;

      driSupport32Bit = true;
    };
  };

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  system.stateVersion = "${stateVersion}";
}
