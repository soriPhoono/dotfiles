{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "systemd.show_status=false"
      "udev.log_level=3"
    ];

    initrd.verbose = false;

    consoleLogLevel = 0;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    plymouth.enable = true;
  };

  zramSwap.enable = true;

  security.sudo.wheelNeedsPassword = false;
}
