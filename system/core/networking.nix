{ config, pkgs, ... }: {
  networking = {
    hostName = "test";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };

    firewall = {
      enable = true;

      allowPing = false;
    };
  };

  services.resolved.enable = true;
}
