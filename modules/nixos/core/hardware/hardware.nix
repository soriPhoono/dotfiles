{lib, ...}: {
  imports = [
    ./gpu/gpu.nix
    ./hid/hid.nix

    ./ssd.nix

    ./android.nix
  ];

  options.core.hardware.enable = lib.mkEnableOption "Enable hardware support";
}
