{
  hardware.i2c.enable = true;

  services.hardware.openrgb = {
    enable = true;
  };

  users.users.soriphoono.extraGroups = [
    "video"
  ];
}
