{ lib, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/graphics.nix

    ../../modules/services/pipewire.nix
  ];

  system.stateVersion = lib.mkDefault "24.11";
}
