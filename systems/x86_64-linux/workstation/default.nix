{
  facter.reportPath = ../../../facter/workstation.json;

  core = {
    boot.plymouth.enable = true;

    hardware = {
      enable = true;
      android.enable = true;
      bluetooth.enable = true;
      monitors.enable = true;
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
        gamepads.enable = true;
      };
    };

    networking = {
      enable = true;
      wireless.enable = true;
      openssh.enable = true;
    };

    services = {
      geoclue2.enable = true;
      pipewire.enable = true;
    };

    suites = {
      power.enable = true;
    };
  };

  desktop = {
    environments.noir.enable = true;
    suites.gaming.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.steam.gamescopeSession.args = [
    "-W 1920"
    "-H 1080"
    "-r 144"
    "--prefer-output DP-5"
  ];
}
