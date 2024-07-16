{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.enable = true;
  boot.kernelParams = [ "i915.force_probe=a780" ];
}
