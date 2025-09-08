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

      hid = {
        tablet.enable = true;
        xbox_controllers.enable = true;
      };

      adb.enable = true;
      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale = {
        enable = true;
      };
    };

    users = {
      soriphoono = {
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
    };
  };

  desktop = {
    environments.kde.enable = true;
    services.asusd.enable = true;
    features = {
      virtualisation.enable = true;
      printing.enable = true;
      gaming = {
        enable = true;
        vr.enable = true;
      };
    };
  };
}
