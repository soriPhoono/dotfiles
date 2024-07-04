{ pkgs-unstable, vars, ... }: {
  services.hardware.openrgb = {
    enable = true;

    package = pkgs-unstable.openrgb-with-all-plugins;
  };

  users.users.${vars.defaultUser}.extraGroups = [
    "video"
  ];
}
