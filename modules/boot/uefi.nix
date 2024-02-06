{ pkgs, ... }: {
  boot = {
    # Use the systemd-boot bootloader.
    loader = {
      efi.canTouchEfiVariables = true; # Allow the bootloader to modify EFI variables.

      systemd-boot = {
        enable = true; # This is the default, but let's be explicit.
        consoleMode = "max"; # Enable more detailed output.
      };
    };
  };
}
