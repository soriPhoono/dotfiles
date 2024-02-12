{ ... }: {
  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };
}
