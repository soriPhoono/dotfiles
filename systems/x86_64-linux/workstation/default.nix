{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  users = {
    extraGroups.funkwhale = {};
    extraUsers = {
      funkwhale = {
        group = "funkwhale";
        shell = pkgs.bash;
        createHome = true;
        home = "/srv/funkwhale";
        isSystemUser = true;
      };
    };
  };

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
        tablet.enable = true;
      };

      adb.enable = true;
      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };

    users = {
      soriphoono = {
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
      spookyskelly = {
        hashedPassword = "$y$j9T$2ClMbK8AGR2tDvxqsQi7N/$VoJZOzxRwbq6GZ9zBR0E2gq0GsZ3Oo27RcjCyG/Gct5";
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEe5elK6ZPxVfoUBM1Ytd9/15OjdTeIfyUU61qR3osP8";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features = {
      hosting.enable = true;
      virtualisation.enable = true;
      gaming.enable = true;
    };
  };

  themes.catppuccin.enable = true;
}
