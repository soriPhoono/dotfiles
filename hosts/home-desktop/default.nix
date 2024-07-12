{
  imports = [
    ./hardware-configuration.nix

    ../../modules
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/graphics.nix

    ../../modules/services/pipewire.nix
  ];
}
