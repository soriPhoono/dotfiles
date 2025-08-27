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
      tailscale = {
        enable = true;
      };
    };

    users = {
      soriphoono = {
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        extraGroups = [
          "adbusers"
        ];
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
      spookyskelly = {
        hashedPassword = "$y$j9T$2ClMbK8AGR2tDvxqsQi7N/$VoJZOzxRwbq6GZ9zBR0E2gq0GsZ3Oo27RcjCyG/Gct5";
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMKr5+AriekN7pqmK2bIAWbYqulnxTHL56+dB9Od6vs";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    services = {
      asusd.enable = true;
      openrazer.enable = true;
    };
    features = {
      hosting.enable = true;
      virtualisation.enable = true;
      gaming.enable = true;
    };
  };

  themes.catppuccin.enable = true;
}
