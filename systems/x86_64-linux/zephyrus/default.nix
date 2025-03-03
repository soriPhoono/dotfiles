{
  facter.reportPath = ../../../facter/zephyrus.json;

  core = {
    boot = {
      secrets.defaultSopsFile = ./vault.yaml;
      plymouth.enable = true;
    };

    hardware = {
      enable = true;
      ssd.enable = true;
      android.enable = true;
      bluetooth.enable = true;
      monitors.enable = true;
      gpu = {
        enable = true;
        integrated.amd.enable = true;
        dedicated.nvidia = {
          enable = true;
          mode = "laptop";
        };
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
      tlp.enable = true;
    };
  };

  desktop = {
    environments.noir.enable = true;
    services.asusd.enable = true;
    suites.gaming.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
