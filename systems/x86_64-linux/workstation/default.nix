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
          device_id = "a780";
        };
        dedicated.amd.enable = true;
      };
      hid = {
        logitech.enable = true;
        qmk.enable = true;
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
