{
  imports = [
    ./hardware-configuration.nix

    ../../modules
    
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/graphics.nix
    ../../modules/hardware/i2c.nix
    ../../modules/hardware/logitech.nix
    ../../modules/hardware/qmk.nix
    ../../modules/hardware/xbox.nix

    ../../modules/programs/steam.nix

    ../../modules/services/pipewire.nix
  ];
}
