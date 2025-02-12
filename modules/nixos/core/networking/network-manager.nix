{
  lib,
  config,
  ...
}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  users.users = lib.genAttrs config.core.users.users (_: {
    extraGroups = ["networkmanager"];
  });

  services.resolved = {
    enable = true;

    dnsovertls = "opportunistic";
  };

  core.boot.impermanence.directories = [
    "/etc/NetworkManager/system-connections"
  ];
}
