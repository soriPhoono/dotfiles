{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  core = {
    boot.enable = true;

    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.amd.enable = true;
        dedicated.nvidia = {
          enable = true;
          laptopMode = true;
        };
      };

      hid = {
        xbox_controllers.enable = true;
      };

      adb.enable = true;
      bluetooth.enable = true;
    };

    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
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
    };
  };

  desktop = {
    environments = {
      kde.enable = true;
      managers.hyprland.enable = true;
    };
    features = {
      virtualisation.enable = true;
      gaming.enable = true;
    };
    services.asusd.enable = true;
  };

  theme = {
    font = {
      serif = {
        package = pkgs.nerd-fonts.liberation;
        name = "LiterationSerif Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.liberation;
        name = "LiterationSans Nerd Font Propo";
      };

      monospace = {
        package = pkgs.nerd-fonts.sauce-code-pro;
        name = "SauceCodePro Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "NotoColorEmoji Nerd Font Propo";
      };
    };
  };

  hosting.docker.enable = true;
}
