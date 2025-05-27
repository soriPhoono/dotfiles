{
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.intel = {
          enable = true;
          deviceId = "a780";
        };
        dedicated.amd.enable = true;
      };

      hid = {
        logitech.enable = true;
        qmk.enable = true;
        xbox_controllers.enable = true;
      };

      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale = {
        enable = true;
        tn_name = "xerus-augmented.ts.net";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features.gaming = {
      enable = true;
      featureType = ["desktop" "vr"];
    };
  };

  server.enable = true;

  themes.catppuccin.enable = true;
}
