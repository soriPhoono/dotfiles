{lib, ...}: {
  imports = [
    ./gpu/gpu.nix

    ./ssd.nix
  ];

  options.core.hardware.enable = lib.mkEnableOption "Enable hardware support";
}
