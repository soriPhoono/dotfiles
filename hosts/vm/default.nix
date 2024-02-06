{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.

    ../../modules/boot/uefi.nix   # Include the UEFI boot loader.
    ../../modules/cli             # Include the default CLI.
    ../../modules/personal/development/git.nix # Include git configuration.
  ];

  boot = {
    loader.timeout = 3; # Reduce the timeout to 3 seconds.

    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp.
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
      cleanOnBoot = true; # Clean /tmp on boot.
    };
  };

  networking.hostName = "virtual-machine"; # Set the hostname to "virtual-machine".
}
