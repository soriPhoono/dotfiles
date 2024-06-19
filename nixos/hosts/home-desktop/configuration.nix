{ stateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/core
    ../../modules/nixos/core/file-system.nix
    ../../modules/nixos/core/localization.nix
    ../../modules/nixos/core/network-manager.nix

    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/i2c.nix
    ../../modules/nixos/hardware/logitech.nix
    ../../modules/nixos/hardware/opengl.nix
    ../../modules/nixos/hardware/qmk.nix
    ../../modules/nixos/hardware/xbox.nix

    ../../modules/nixos/programs
    ../../modules/nixos/programs/gaming.nix

    ../../modules/nixos/services/auto-cpufreq.nix
    ../../modules/nixos/services/openrgb.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/pipewire.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/ratbagd.nix
    ../../modules/nixos/services/zram-generator.nix

    ../../modules/nixos/desktops/kde.nix
  ];

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend
  '';

  system.stateVersion = "${stateVersion}";
}
