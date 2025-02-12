{
  core = {
    boot = {
      plymouth.enable = true;
    };

    hardware = {
      enable = true;
      ssd.enable = true;
      gpu = {
        enable = true;
        integrated.amd.enable = true;
        dedicated.nvidia.enable = true;
      };
    };

    services = {
      asusd.enable = true;
      geoclue2.enable = true;
    };

    power.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
