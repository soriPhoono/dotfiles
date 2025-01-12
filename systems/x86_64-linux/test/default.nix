{
  core.enable = true;

  system = {
    hardware.gpu = {
      intel.internal = {
        enable = true;
        device_id = ""; # TODO: fix this
      };

      amd.dedicated.enable = true;
    };

    boot = {
      enable = true;
      plymouth.enable = true;
    };

    brightness.enable = true;
    pipewire.enable = true;
    power.enable = true;

    bluetooth.enable = true;
    networking.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
