{
  facter.reportPath = ../../../facter/zephyrus.json;

  core = {
    boot = {
      secrets.defaultSopsFile = ./vault.yaml;
    };

    hardware = {
      enable = true;

      android.enable = true;
      bluetooth.enable = true;

      gpu = {
        enable = true;
        integrated.amd.enable = true;
        dedicated.nvidia = {
          enable = true;
          laptopMode = true;
        };
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
  };

  desktop = {
    environments.hyprland.enable = true;
    services.asusd.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
