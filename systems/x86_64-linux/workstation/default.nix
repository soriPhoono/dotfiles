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
          deviceId = "";
        };
        dedicated.amd.enable = true;
      };

      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features.gaming = {
      enable = true;
      featureType = ["desktop" "vr" "console"];
    };
  };

  themes.catppuccin.enable = true;
}
