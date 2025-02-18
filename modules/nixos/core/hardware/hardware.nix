{lib, ...}: {
  imports = [
    ./gpu/gpu.nix

    ./ssd.nix

    ./hid/logitech.nix
    ./hid/qmk.nix
  ];

  options.core.hardware.enable = lib.mkEnableOption "Enable hardware support";
}
