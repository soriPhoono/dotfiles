{
  lib,
  config,
  ...
}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
    insertNameservers = config.networking.nameservers;
  };

  systemd.network.wait-online.enable = false;

  users.users = lib.genAttrs config.core.users.users (_: {
    extraGroups = ["networkmanager"];
  });

  core.boot.impermanence.directories = [
    "/etc/NetworkManager/system-connections"
  ];
}
