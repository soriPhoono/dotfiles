{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.amd.enable = true;
        dedicated.nvidia.enable = true;
      };

      hid.tablet.enable = true;

      adb.enable = true;
      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      homepage.enable = true;
      tailscale = {
        enable = true;
        tn_name = "xerus-augmented.ts.net";
      };
    };

    users = {
      soriphoono = {
        email = "soriphoono@gmail.com";
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        extraGroups = [
          "adbusers"
        ];
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features.gaming = {
      enable = true;
      featureType = ["desktop"];
    };
  };

  themes.catppuccin.enable = true;
}
