{ pkgs, ... }: {
  boot = {
    loader = {
      timeout = 3;

      efi.canTouchEfiVariables = true; # Allow the bootloader to modify EFI variables.

      systemd-boot = {
        enable = true; # This is the default, but let's be explicit.
        consoleMode = "max"; # Enable more detailed output.
      };
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_6_7; # Use the 6.7 kernel.

    tmp = {
      useTmpfs = true; # Use a tmpfs for /tmp.
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
      cleanOnBoot = true; # Clean /tmp on boot.
    };
  };
}
