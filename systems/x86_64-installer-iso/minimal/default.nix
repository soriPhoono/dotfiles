{lib, ...}: {
  networking.wireless.enable = lib.mkForce false;

  core = {
    hardware = {
      gpu.enable = true;
      bluetooth.enable = true;
    };

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.gnome.enable = true;
}
