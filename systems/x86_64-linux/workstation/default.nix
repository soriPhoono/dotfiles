{
  facter.reportPath = ../../../facter/workstation.json;

  services.greetd.settings.initial_session.user = "soriphoono";

  core = {
    boot = {
      secrets.defaultSopsFile = ./vault.yaml;
      plymouth.enable = true;
    };

    hardware = {
      enable = true;

      android.enable = true;
      bluetooth.enable = true;

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
      tailscale.enable = true;
    };

    services = {
      fstrim.enable = true;
      geoclue2.enable = true;
      pipewire.enable = true;
      tlp.enable = true;
    };
  };

  desktop = {
    environments.noir.enable = true;
    suites.gaming = {
      enable = true;
      mode = "desktop";
    };
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
