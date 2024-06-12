{ vars, ... }: {
  services.hardware.openrgb.enable = true;

  users.users.${vars.defaultUser}.extraGroups = [
    "video"
  ];
}
