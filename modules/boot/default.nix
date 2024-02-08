{ pkgs, ... }: {
  boot = {
    loader.timeout = 3; # Reduce the timeout to 3 seconds.

    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp.
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
      cleanOnBoot = true; # Clean /tmp on boot.
    };
  };

  zramSwap.enable = true; # Enable zram swap.
}
