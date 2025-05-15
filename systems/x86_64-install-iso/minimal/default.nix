{lib, ...}: {
  networking.wireless.enable = lib.mkForce false;

  core = {
    hardware = {
      bluetooth.enable = true;
    };

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.plasma.enable = true;
}
