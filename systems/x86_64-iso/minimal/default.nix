{
  core = {
    hardware.gpu.enable = true;

    boot.enable = true;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  themes.catppuccin.enable = true;
}
