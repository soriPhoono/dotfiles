{ lib, ... }: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi.powersave = true;
  };

  services.resolved.enable = true;

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce = false;
}
