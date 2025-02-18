{
  facter.reportPath = ../../../facter/workstation.json;

  core = {
    boot = {
      plymouth.enable = true;
    };

    hardware = {
      enable = true;
      ssd.enable = true;
      gpu = {
        enable = true;
        integrated.intel = {
          enable = true;
          device_id = ""; # TODO: fill this out
        };
        dedicated.amd.enable = true;
      };
    };

    services = {
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
