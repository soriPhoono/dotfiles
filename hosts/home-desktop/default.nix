{
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
}
