{ ... }: {
  services.zram-generator = {
    enable = true;

    settings = {
      zram0 = {
        zram-size = "ram / 2";
      };
    };
  };
}