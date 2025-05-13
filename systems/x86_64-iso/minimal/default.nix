{
  core = {
    hardware = {
      gpu.enable = true;

      bluetooth.enable = true;
    };

    boot.enable = true;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.plasma.enable = true;

  themes.catppuccin.enable = true;
}
