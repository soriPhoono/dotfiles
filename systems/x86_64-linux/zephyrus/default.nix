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
    suites.gaming = {
      enable = true;
      gamescopeMode = {
        args = [
          "-W 1920"
          "-H 1080"
          "-r 144"
          "--rt"
          "-e"
        ];
        env = {
          LD_PRELOAD = "\"\"";
        };
      };
    };
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
