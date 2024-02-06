{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.

    ../../modules/boot/uefi.nix   # Include the UEFI boot loader.
    ../../modules/personal/development/git.nix # Include git configuration.
  ];

  boot = {
    loader.timeout = 3; # Reduce the timeout to 3 seconds.

    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.
  };

  networking.hostName = "virtual-machine"; # Set the hostname to "virtual-machine".
}
