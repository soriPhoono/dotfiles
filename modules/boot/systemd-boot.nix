{ ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;

        memtest86.enable = true;
      };

      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };
}