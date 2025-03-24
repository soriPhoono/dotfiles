{
  facter.reportPath = ../../../facter/workstation.json;

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
  };

  desktop = {
    environments.hyprland.enable = true;
    suites.gaming = {
      enable = true;
      gamescopeMode = {
        args = [
          "-W 1920"
          "-H 1080"
          "-r 144"
          "--rt"
          "-e"
          "-O DP-1"
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
